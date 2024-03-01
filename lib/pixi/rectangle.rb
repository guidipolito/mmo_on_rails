module PIXI
  class Rectangle
    extend Native::Helpers
    include Native::Wrapper
    native_accessor :x, :y

    def initialize(x, y, width, height)
      @native = `new PIXI.Rectangle(#{x}, #{y}, #{width}, #{height})`
    end

    def to_n = @native
  end
end
