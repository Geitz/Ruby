#!/usr/bin/ruby

require 'socket'


class UDPServer

  attr_accessor :port

  def initialize(port=4321)
    @port = port
  end

  def launchServer
    loop do
      sThread = Thread.start do    # run server in a thread

        server = UDPSocket.open
        server.bind("0.0.0.0", 4242)
        #puts "Server waiting for message"
        msg = server.recvfrom(64)
        puts msg
        f = File.new("IP_conf.txt", "w")
        f.puts msg[1][2].to_s
        if msg[0] == "exit"
          puts "TIME TO ESCAAAAAAPE"
          return -1
        end
      end # END OF THREAD


    end # END OF LOOP
    puts "server exited loop"
  end # END OF 'connectServer'



end # END OF CLASS UDPServer