require 'native'
require 'pixi/pixi'
require 'map'

class Game
  include PIXI
  def initialize
    @app = PIXI::Application.new('#1099bb')
    @tick = 0
    @app.on_update { @tick += 1 }
    @app.on_update(&method(:game_loop))
    @fps_label = PIXI::Text.new
    @map = Map.new @app
    @app.add_child @fps_label
  end

  def game_loop(_delta)
    @fps_label.text = "fps: #{@app.fps}"
  end
end

Game.new
