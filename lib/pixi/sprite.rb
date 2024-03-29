module PIXI
  class Sprite < PIXI::Movable
    def initialize(url, options = {})
      defaults = { frame_width: 32, frame_height: 32, texture: false }
      options = defaults.merge options
      if url.is_a? Hash
        options = defaults.merge(url)
        url = false
      end

      if options[:texture].is_a? PIXI::Texture
        @frame = false
        @texture = options[:texture]
      elsif url
        @frame = PIXI::Rectangle.new(0, 0, options[:frame_width], options[:frame_height])
        @texture = PIXI::Texture.new(url, @frame)
      end

      @native = `new PIXI.Sprite(#{@texture.to_n})`
    end

    def set_frame(col, line)
      return false unless @frame

      @frame.x = col * 32
      @frame.y = line * 32
    end
  end
end
