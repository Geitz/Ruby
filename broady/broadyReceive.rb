#!/usr/bin/ruby


require 'socket'
require 'ipaddr'

Socket::IP_ADD_MEMBERSHIP = 12 unless Socket.const_defined?('IP_ADD_MEMBERSHIP')

MULTICAST_ADDR = '225.3.2.1'
PORT = 3001

ip = IPAddr.new(MULTICAST_ADDR).hton + IPAddr.new('0.0.0.0').hton

socket = UDPSocket.new
socket.bind('0.0.0.0', PORT)
socket.setsockopt(Socket::IPPROTO_IP, Socket::IP_ADD_MEMBERSHIP, ip)

loop do
  msg, info = socket.recvfrom(1024)
  puts "MSG: #{msg} FROM: #{info[0]} (#{info[3]})/#{info[1]} LEN: #{msg.size}"
end