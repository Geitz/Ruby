#!/usr/bin/ruby

require_relative './src/UDPServer.rb'
require_relative './src/UDPClient.rb'
BEGIN {
  # Ce block est appelé au démarrage du programme
  puts 'The daemon begin'

  # $stdout.sync = true
}

if __FILE__ == $0
  puts 'Main start'

  udpServ = UDPServer.new()
  mT = Thread.start do
    udpServ.launchServer()
  end

  client = UDPClient.new("127.0.0.1", 4242, 0)
  AT = Thread.start do
  client.sendMsg("exit")
  end
  sleep 2.2


  #TODO: crée un fichier de configuration si il existe pas déjà
  #TODO: si il existe le lire et configurer le programme en fonction

end

END {
  # Ce block est appelé avant que le programme quitte

  puts 'The daemon end'
}
