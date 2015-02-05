#!/usr/bin/ruby

require 'socket'

class UDPClient

  attr_accessor :msg
  attr_accessor :hostame
  attr_accessor :port
  attr_accessor :flag
  attr_accessor :role
  attr_accessor :mIP

  def initialize(hostname, port, flag= 0)

    @hostame = hostname
    @port = port
    @flag = flag

    f = File.open("./conf/mIP_conf.txt", "r+")
    @role = f.gets
    @mIP = f.gets

    puts "role = " + @role
    puts "mIP = " + @mIP

  end

  def sendMsg(msg="empty message")
    sock = UDPSocket.open
    sock.connect(@hostame, @port)
    sock.send(msg, @flag)
  end


end