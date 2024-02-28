module PIXI
  class Sprite
    extend Native::Helpers
    native_accessor :x
    native_accessor :y
    native_accessor :rotation
    attr_reader :native

    def initialize(texture)
      @native = `new PIXI.Sprite(#{texture})`
    end
  end
end
