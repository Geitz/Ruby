require 'rubygems'
require 'gosu'
require_relative 'Player'
require_relative 'Window'
require_relative 'Star'

module ZOrder
  Background, Stars, Player, UI = *0..3
end