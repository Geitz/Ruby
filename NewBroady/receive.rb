require "socket"
require "ipaddr"

MULTICAST_ADDR = "225.3.2.1"
BIND_ADDR = "0.0.0.0"
PORT = 33336

socket = UDPSocket.new
membership = IPAddr.new(MULTICAST_ADDR).hton + IPAddr.new(BIND_ADDR).hton

socket.setsockopt(:IPPROTO_IP, :IP_ADD_MEMBERSHIP, membership)
socket.setsockopt(:SOL_SOCKET, :SO_REUSEADDR, 1)



socket.bind(BIND_ADDR, PORT)

loop do
  message, _ = socket.recvfrom(255)
  puts message
end