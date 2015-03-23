#!/usr/bin/ruby

require 'socket'
require 'ipaddr'
require 'io/console'

def getIP
  stringTest = Socket.ip_address_list.to_s
  myArray = []

  stringTest.gsub!(", ", "\n")
  stringTest.each_line do |line|
    mString = line.split(": ")[1].chomp
    mString.gsub!(">", "")
    mString.gsub!("]", "")
    if /^([0-9]{1,3}[\.]){3}[0-9]{1,3}$/ === mString
      myArray << mString
    end
  end
  return myArray
end

## END OF GET_IP ##

Socket::IP_ADD_MEMBERSHIP = 12 unless Socket.const_defined?('IP_ADD_MEMBERSHIP')
MULTICAST_ADDR = '225.3.2.1'
PORT = 33333
port = 33333
i = 0

## END OF DECLARATION ##

myArray = getIP
socket = UDPSocket.new
socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, 1)
ip = IPAddr.new(MULTICAST_ADDR).hton + IPAddr.new(myArray[1]).hton
socket.setsockopt(Socket::IPPROTO_IP, Socket::IP_ADD_MEMBERSHIP, ip)

## END OF INITIALIZATION ##

socket.bind(myArray[i], port)

Th = Thread.start do ## Thread who receives messages
  loop do
    message = socket.recvfrom(1024) # Get message + sender's information
    puts message                    # Print message + information on standard output

    if message[0] == 'quit'         # test log for proper exit
      puts 'quit detected'
      exit
    end
  end
end


  puts '<'+myArray[i].chomp+'>'   # print my IP on standard output
  puts port                       # print the port
  mFile = File.open('conf.txt', 'w+') # open a file or creates it
  mFile.write(myArray[i])         # Write IP in file

  #socket.bind(myArray[i], PORT)
  #socket.bind('0.0.0.0', port)
  sleep 0.1

loop do                           # send message
  msg = 'empty'
  msg = gets.chomp
  socket.send(msg, 0, myArray[i].chomp, PORT)
end


#####################################################

# port += 1
#  i += 1
#end


#socket = UDPSocket.new
#socket.setsockopt(Socket::IPPROTO_IP, Socket::IP_ADD_MEMBERSHIP, ip)
