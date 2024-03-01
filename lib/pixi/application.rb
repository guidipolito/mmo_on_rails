require 'native'

module PIXI
  class Application
    attr_reader :container, :view

    def initialize(color, fullscreen = false)
      @app = Native `new PIXI.Application({ background: #{color} });`
      if fullscreen
        @app.resizeTo = `window`
        @app.resize
      end
      @app.ticker.maxFPS=60
      @view = @app[:view]
    end

    def add_child(obj)
      @app.stage.addChild obj.to_n
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
