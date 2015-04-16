require 'socket'
require 'ipaddr'

MULTICAST_ADDR = '225.3.2.1'
BIND_ADDR = '0.0.0.0'
PORT = 33336
stringTest = Socket.ip_address_list.to_s
myArray = []
ipArray = []
mAddress = ''
i = 0

stringTest.gsub!(", ", "\n")
stringTest.each_line do |line|
  mString = line.split(": ")[1].chomp
  mString.gsub!(">", "")
  mString.gsub!("]", "")
  if /^([0-9]{1,3}[\.]){3}[0-9]{1,3}$/ === mString
    myArray << mString
  end
end

if myArray[0] != '127.0.0.1'
  mAddress = myArray[0]
elsif (myArray[0] == '127.0.0.1' and myArray[1] != nil)
  mAddress = myArray[1]
end


##################################

mFile = File.open('otherDevicesDiscovered.txt', 'w+') ## open a file or creates it ##
mFile.puts('my address : ' + mAddress)

#################################


socket = UDPSocket.new
membership = IPAddr.new(MULTICAST_ADDR).hton + IPAddr.new(BIND_ADDR).hton

socket.setsockopt(:IPPROTO_IP, :IP_ADD_MEMBERSHIP, membership)
socket.setsockopt(:IPPROTO_IP, :IP_MULTICAST_TTL, 1)
socket.setsockopt(:SOL_SOCKET, :SO_REUSEADDR, 1)


socket.bind(BIND_ADDR, PORT)
Th = Thread.start do
  loop do
    message, _ = socket.recvfrom(255) ## POUR L INSTANT ON RECUP QUE LE MESSAGE, POSSIBILITÉ de récup + d'info en virant le '_
    if (ipArray.include?(message) == FALSE)
      puts 'received : ' + message
      mFile.puts(message)
      ipArray << message
    else
      puts 'Already in the array'
    end
  end
end

msg = gets.chomp

while msg != 'exit' do
  socket.send(msg, 0, MULTICAST_ADDR, PORT)
  msg = gets.chomp
end

puts 'ipArray : ' + ipArray.to_s