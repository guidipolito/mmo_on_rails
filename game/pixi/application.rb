require 'element'
require 'native'

module PIXI
  class Application
    attr_reader :container

    def initialize(color)
      @app = Native `new PIXI.Application({ background: #{color}, resizeTo: window });`
      @app.ticker.maxFPS = 120
      Element.new('body').append_child @app[:view]
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
