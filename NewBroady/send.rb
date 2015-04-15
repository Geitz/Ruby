require "socket"

MULTICAST_ADDR = '225.3.2.1'
PORT = 33336

socket = UDPSocket.open
socket.setsockopt(:IPPROTO_IP, :IP_MULTICAST_TTL, 1)
msg = gets.chomp

while msg != 'exit' do
  socket.send(msg, 0, MULTICAST_ADDR, PORT)
  msg = gets.chomp

end
socket.close