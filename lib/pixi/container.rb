module PIXI
  class Container < PIXI::Movable
    def initialize()
      @native = `new PIXI.Container()`
    end

    def add_child(obj)
      @native.JS.addChild obj.native
    end
  end
end
