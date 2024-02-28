require 'native'
require 'pixi/pixi.rb'

class Game
  include PIXI
  def initialize
    @app = PIXI::Application.new("#1099bb")
    25.times do |i|
      texture = @app.load_texture "https://pixijs.com/assets/bunny.png"
      bunny = PIXI::Sprite.new(texture)
      bunny.x = (i % 5) * 40
      bunny.y = (i / 5).floor * 40
      @app.add_child bunny
    end
    @app.on_update &method(:game_loop)
  end

  def game_loop(delta)
    @app.container.rotation += 0.2 * delta
  end
end

Game.new
