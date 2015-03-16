require 'socket'
stringTest = Socket.ip_address_list.to_s
myArray = []
i = 0
port = 88888

stringTest.gsub!(", ", "\n")
stringTest.each_line do |line|
  mString = line.split(": ")[1].chomp
  mString.gsub!(">", "")
  mString.gsub!("]", "")
  if /^([0-9]{1,3}[\.]){3}[0-9]{1,3}$/ === mString
    myArray << mString
  end
end

puts "---"

while myArray[i] != nil
  socket = UDPSocket.open
  socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, 1)
  puts myArray[i]
  puts port
  socket.bind(myArray[i].chomp, port)

  socket.send("sample data", 0, myArray[i].chomp, port)
  sleep 0.1
  port += 1
  i += 1
end

#
# loop do

  #p socket.recvfrom(20)
  #socket.send('MASTER', 0, '127.0.0.1', 23000)
  #sock.send(data, 0, '130.237.156.134', 23000)
  #data = gets.chomp()
  #end

 #sock.close
