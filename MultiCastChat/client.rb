require 'socket'
require 'ipaddr'

MULTICAST_ADDR = '239.255.255.250'
LOCATOR_PORT = 24067

membership = IPAddr.new(MULTICAST_ADDR).hton + IPAddr.new("0.0.0.0").hton
sock = UDPSocket.open
sock.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, 1)

begin
  sock.bind(Socket::INADDR_ANY, LOCATOR_PORT)
rescue Errno::EADDRINUSE
  p :here
  raise Error, "Unable to listen on port #{LOCATOR_PORT},"
end

sock.setsockopt(Socket::IPPROTO_IP, Socket::IP_ADD_MEMBERSHIP, membership)
sock.send(ARGV[0], 0, MULTICAST_ADDR, LOCATOR_PORT)


loop do
  message, _ = sock.recvfrom(255)
  puts message

  if message.to_s == "quit"
    exit
  end


end
sock.close