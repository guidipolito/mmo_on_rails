module PIXI
  class Container
    extend Native::Helpers
    native_accessor :x
    native_accessor :y
    native_accessor :rotation
    attr_reader :native

    def initialize(texture)
      @native = `new PIXI.Container(#{texture})`
    end

    def add_child(obj)
      @native.JS.addChild obj.native
    end
  end
end
