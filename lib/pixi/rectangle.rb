module PIXI
  class Rectangle
    extend Native::Helpers

    native_accessor :x, :y
    attr_reader :native
    def initialize(x, y, width, height)
      @native = `new PIXI.Rectangle(#{x}, #{y}, #{width}, #{height})`
    end
  end
end
