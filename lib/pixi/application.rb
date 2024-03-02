require 'native'

module PIXI
  class Application
    extend Native::Helpers
    attr_reader :container, :view

    native_accessor :resizeTo
    native_accessor :resize
    def fps = @native.ticker.FPS
    def stage = @native.stage
    def to_n = @native.to_n

    def initialize(color, fullscreen = false)
      @native = Native `new PIXI.Application({ background: #{color} });`
      if fullscreen
        @native.resizeTo = `window`
        @native.resize
      end
      @native.ticker.maxFPS = 60
      @view = @native[:view]
    end


    def add_child(obj)
      @native.stage.addChild obj.to_n
      obj
    end

    def on_update(&block)
      @native.ticker.add block
    end

    def max_fps=(fps)
      @native.ticker.maxFPS = fps
    end
  end
end
