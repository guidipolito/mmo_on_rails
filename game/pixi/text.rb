module PIXI
  class Text < PIXI::Movable
    native_accessor :text
    def initialize(text)
      @native = `new PIXI.Text(#{text})`
    end
  end
end
