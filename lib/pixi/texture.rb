module PIXI
  class Texture
    extend Native::Helpers
    include Native::Wrapper
    # native variables
    native_accessor :EMPTY
    native_accessor :WHITE
    native_accessor :_frame
    alias_native :default_anchor, :defaultAnchor
    native_accessor :frame
    native_accessor :width
    native_accessor :height
    alias_native :no_frame, :noFrame
    native_accessor :orig
    native_accessor :resolution
    native_accessor :rotate
    alias_native :texture_cache_ids, :textureCacheIds
    native_accessor :trim
    alias_native :uv_matrix, :uvMatrix
    native_accessor :valid
    attr_reader :base_texture
    attr_reader :native

    # native methods
    alias_native :add_to_cache, :addToCache
    native_accessor :from
    alias_native :from_buffer, :fromBuffer

    def initialize(url, frame = false)
      @base_texture = Native `PIXI.BaseTexture.from(#{url})`
      @native = if frame.is_a? PIXI::Rectangle
                  `new PIXI.Texture(#{base_texture.to_n}, #{frame.to_n});`
                else
                  `new PIXI.Texture(#{base_texture.to_n});`
                end
    end

    def img_width = @base_texture.resource.width
    def img_height = @base_texture.resource.height

    def on_load(&block)
      @base_texture.on('loaded', &block) if block_given?
    end
  end
end
