#!/usr/bin/ruby

require 'socket'
require 'ipaddr'
require 'io/console'

## FUNCTION GET_IP ##

def getIP
  stringTest = Socket.ip_address_list.to_s            ## GET DEVICE IP ##
  myArray = []

  stringTest.gsub!(", ", "\n")
  stringTest.each_line do |line|
    mString = line.split(": ")[1].chomp               ## FORMATTING ##
    mString.gsub!(">", "")                            ## FORMATTING ##
    mString.gsub!("]", "")                            ## FORMATTING ##
    if /^([0-9]{1,3}[\.]){3}[0-9]{1,3}$/ === mString  ## REGEX ##
      myArray << mString
    end
  end
  return myArray                                      ## RETURN IP ARRAY ##
end

## END OF GET_IP ##
## BEGIN OF BINDING ##

def Binding(mIP, mPort, mSocket)
  mSocket.bind(mIP, mPort)
  rescue => e
  #puts 'ERROR LOG: ' + e.to_s
  if e == nil
    return 0
  else
    return -1
  end
end

## END OF BINDING ##
## BEGIN DECLARATION ##

Socket::IP_ADD_MEMBERSHIP = 12 unless Socket.const_defined?('IP_ADD_MEMBERSHIP')
MULTICAST_ADDR = '225.3.2.1'
PORT = 33333
port = 33333
i = 0

## END OF DECLARATION ##
## BEGIN INITIALIZATION ##

myArray = getIP                     ## IP IN MY_ARRAY ##
socket = UDPSocket.new
socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_BROADCAST, 1)
ip = IPAddr.new(MULTICAST_ADDR).hton + IPAddr.new(myArray[1]).hton
socket.setsockopt(Socket::IPPROTO_IP, Socket::IP_ADD_MEMBERSHIP, ip)

## END OF INITIALIZATION ##
## BEGIN EXECUTION ##

var = Binding('0.0.0.0', port, socket)
## Exemple biding ---- Binding(myArray[i], port, socket)   ## if return 0 => success || return -1 => failed ##

Th = Thread.start do                ## Thread who receives messages ##
  message = socket.recvfrom(1024) ## Get message + sender's information ##
puts 'log'
  while message[0] != 'quit' do
    print 'Th waiting. var = '
    puts var
    message = socket.recvfrom(1024) ## Get message + sender's information ##
    puts message[0]                 ## Print message + information on standard output ##
  end
  puts 'exited loop'
end

loop do
  #print 'var = '
  #puts var
  if var == 0                       ## BINDING SUCCEED ##
    msg = '[empty]'                 ## Initialize msg ##
    puts 'var = 0'                  ## Debug ##
    msg = gets.chomp                ## Gets input -> Will be replace by listening to others msg (in a list ?) ##
    socket.send(msg, 0, myArray[i].chomp, port) ## Send message ##
  else                              ## ELSE = IF BINDING HAS FAILED ##
    if myArray[i + 1] == nil
      i = 0
      puts 'var < 0'
      sleep 1
      var = Binding(myArray[i], port, socket)
    else
      i = i + 1
      puts 'var < 0'
      sleep 1
      var = Binding(myArray[i], port, socket)
    end
  end
end


#####################

#puts myArray[i].chomp       ## DEBUG print my IP on standard output ##
  #puts port                           ## DEBUG print the port ##
  #mFile = File.open('conf.txt', 'w+') ## open a file or creates it ##
  #mFile.write(myArray[i])             ## Write IP in file ##
  #sleep 0.1

#loop do                               ## 'sending message' loop ##
 # msg = 'empty'
  #msg = gets.chomp
  #socket.send(msg, 0, myArray[i].chomp, PORT)
#end

#####################################

# port += 1
#  i += 1
#end
#socket.bind(myArray[i], PORT)
#socket.bind('0.0.0.0', port)


#socket = UDPSocket.new
#socket.setsockopt(Socket::IPPROTO_IP, Socket::IP_ADD_MEMBERSHIP, ip)
