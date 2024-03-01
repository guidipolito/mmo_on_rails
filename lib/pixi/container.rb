module PIXI
  class Container < PIXI::Movable
    def initialize()
      @native = `new PIXI.Container()`
    end

    def add_child(obj)
      @native.JS.addChild obj.to_n end
  end
end
