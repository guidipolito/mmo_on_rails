module PIXI
  class Sprite < PIXI::Movable
    def initialize(url, _frame_width = 32, _frame_height = 32)
      @frame = PIXI::Rectangle.new(0, 0, 32, 32)
      @texture = PIXI::Texture.new(url, @frame)
      @native = `new PIXI.Sprite(#{@texture.native})`
    end

    def set_frame(col, line)
      @frame.x = col * 32
      @frame.y = line * 32
    end
  end
end
