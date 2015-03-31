require 'rubygems'
require 'gosu'
require_relative 'Player'
require_relative 'Star'
require_relative 'ModuleZOrder'

class GameWindow < Gosu::Window
  def initialize
    super(640, 480, false)
    self.caption = "Gosu Tutorial Game"

    @background_image = Gosu::Image.new(self, "assets/img/backgrounds/title.png", true)

    @backsong = Gosu::Song.new(self, "assets/sound/SE/Beep1.wav")

    @player = Player.new(self)
    @player.warp(320, 240)

    @star_anim = Gosu::Image::load_tiles(self, "assets/img/tileset/Orange_Star.png", 13, 13, false)
    @stars = Array.new
    @backsong.play
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def update
    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
      @player.turn_left

      #@player.try_moveLeft

    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
      @player.turn_right
      #player.try_moveRight

    end
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
      @player.accelerate

    end
    @player.move

    @player.collectStar(@stars)
    if rand(100) < 4 and @stars.size < 25 then
      @stars.push(Stars.new(@star_anim))
    end
  end

  def draw
    @background_image.draw(0, 0, ZOrder::Background);
    @player.draw

    @stars.each { |stars| stars.draw }
    @font.draw("Score: #{@player.score}", 10, 10, ZOrder::UI, 1.0, 1.0, 0xffffff00)

  end

  def button_down(id)
    if id == Gosu::KbEscape
      close
    end
  end
end