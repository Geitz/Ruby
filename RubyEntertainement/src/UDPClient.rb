#!/usr/bin/ruby

require 'socket'

class UDPClient

  attr_accessor :msg
  attr_accessor :hostame
  attr_accessor :port
  attr_accessor :flag

  def initialize(hostname, port, flag= 0)

    @hostame = hostname
    @port = port
    @flag = flag
  end

  def sendMsg(msg="empty message")
    sock = UDPSocket.open
    sock.connect(@hostame, @port)
    sock.send(msg, @flag)
  end


end