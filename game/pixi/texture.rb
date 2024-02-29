module PIXI
  class Texture
    extend Native::Helpers
    native_accessor :width
    native_accessor :height
    attr_reader :native
    attr_reader :base_texture
    def initialize(url, frame)
      @base_texture =  `PIXI.BaseTexture.from(#{url})`
      @native = `new PIXI.Texture(#{base_texture}, #{frame.native});`
    end
  end
end
