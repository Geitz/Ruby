require 'rubygems'
require 'gosu'
require_relative 'Star'

class Player
  def initialize(window)
    @image = Gosu::Image.new(window, 'assets/img/tileset/megaman.png', false)
    #@beepSound = Gosu::Sample.new(window, "assets/sound/SE/Beep1.wav")
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 0
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @angle -= 4.5
  end

  def turn_right
    @angle += 4.5
  end

  def accelerate
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def try_moveLeft
    @x = @x -1
  end

  def try_moveRight
    @x = @x + 1
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480

    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def score
    return @score
  end

  def collectStar(stars)
    if stars.reject! {|star| Gosu::distance(@x, @y, star.x, star.y) < 35 } then
      @score += 1
      #@beepSound.play
      true
    else
      false
    end
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end