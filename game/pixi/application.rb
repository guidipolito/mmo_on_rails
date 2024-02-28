require 'element'
require 'native'

module PIXI
  class Application
    attr_reader :container

    def initialize(color)
      @app = Native `new PIXI.Application({ background: #{color}, resizeTo: window });`
      @container = Container.new
      Element.new('body').append_child @app[:view]
      add_child_to_root @container
      @container.x = @app.screen.width / 2
      @container.y = @app.screen.height / 2
    end

    def add_child(obj)
      @container.add_child obj
    end

    def load_texture(url)
      `PIXI.Texture.from(#{url});`
    end

    def on_update(&block)
      @app.ticker.add block
    end

    private

    def add_child_to_root(obj)
      @app.stage.addChild obj.native
    end
  end
end
