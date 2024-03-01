require 'element'
require 'native'

module PIXI
  class Application
    attr_reader :container, :view

    def initialize(color, fullscreen = false)
      @app = Native `new PIXI.Application({ background: #{color} });`
      @app.resizeTo(`window`) if fullscreen
      @app.ticker.maxFPS = 120
      @app[:view]
    end

    def add_child(obj)
      @app.stage.addChild obj.native
    end

    def on_update(&block)
      @app.ticker.add block
    end

    def fps
      @app.ticker.FPS
    end

    def max_fps=(fps)
      @app.ticker.maxFPS = fps
    end
  end
end
