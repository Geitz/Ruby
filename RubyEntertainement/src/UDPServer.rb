#!/usr/bin/ruby

require 'socket'


class UDPServer

  attr_accessor :port

  def initialize(port=4321)
    @port = port
  end

  def launchServer
    server = UDPSocket.open()
    server.bind('', 4242)
    loop do
      sThread = Thread.start do    # run server in a thread
        msg = server.recvfrom(64)
        f = File.new("./conf/IP_conf.txt", "a+")
        f.puts msg[1][2].to_s + " " + msg[0]
        puts msg[1][2].to_s + " " + msg[0] + "has connected"
        puts msg
        if msg[0] == "exit"
          puts "TIME TO ESCAAAAAAPE"
          return -1
        end
      end # END OF THREAD


    end # END OF LOOP
    puts "server exited loop"
  end # END OF 'connectServer'



end # END OF CLASS UDPServer