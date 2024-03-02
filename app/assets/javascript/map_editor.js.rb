require 'opal'
require 'pixi/pixi'
require 'opal-jquery'

class Layout
  attr_reader @node

  def initialize(name)
    @name = name
    @order = 0
  end

  def create_node; end
end

# Tiler Selector.
# Create the tilemap and manipulate selection
class TileSelector
  extend Native::Helpers

  # == Definition lists
  #
  # app::  PIXI::Applicatiion, the canvas
  # selected::
  #   The cursor location relative to the canvas, can be false when the cursor is out
  # map_texture:: the texture loaded in the canvas, used to get width and height
  # url_loaded:: last url loaded
  # tilemap_id:: the id the map should use when inserting the selected tile
  # sprite:: last sprite loaded
  # tilemap_container:: keep sprite below the grid
  # grid_container:: keep grid made by graphics above
  # hover:: array with line and col being hovered
  # tilesize:: Integer of the size in pixels each square have
  def initialize
    @app = PIXI::Application.new('#080808')
    `window.__PIXI_APP__ = #{@app.to_n}`

    @selected = false # can be [int, int]
    @map_texture = false
    @url_loaded = false
    @id = false
    @sprite = false
    @tilemap_container = @app.add_child PIXI::Container.new
    @grid_container = @app.add_child PIXI::Container.new
    @hover = false
    @tilesize = 48
    @graphics = Native(`new PIXI.Graphics`)
    @lines = 0
    @cols = 0
    @grid_container.add_child @graphics
    @app.on_update do
      draw_grid
    end
    setup_cursor_events
  end

  def view = @app.view

  # @param [String] url
  # @param [Integer] id
  def load_tilemap(url, id)
    @sprite.destroy(texture: false) if @sprite
    @url_loaded = url
    @id = id
    @map_texture = PIXI::Texture.new(url)
    @map_texture.on_load(&method(:after_load))
    # check if it was loaded right away
    if @map_texture.img_width != 0
      after_load
    end
  end

  def after_load(*_args)
    width = @map_texture.img_width
    height = @map_texture.img_height
    @app.view.width = width
    @app.view.height = height
    @cols = (width / @tilesize).ceil
    @lines = (height / @tilesize).ceil
    @sprite = @tilemap_container.add_child PIXI::Sprite.new(texture: @map_texture)
  end

  def draw_grid
    @graphics.clear
    @lines.times do |line|
      @cols.times do |col|
        @graphics.lineStyle width: 1, color: '#FFFFFF'
        @graphics.drawRect(col * @tilesize, line * @tilesize, @tilesize, @tilesize)
      end
    end
    # It doens't smells good
    if @hover
      @graphics.lineStyle width: 4, color: '#000000'
      @graphics.drawRect(@hover[1] * @tilesize, @hover[0] * @tilesize, @tilesize, @tilesize)
      @graphics.lineStyle width: 2, color: '#93eacd'
      @graphics.drawRect(@hover[1] * @tilesize, @hover[0] * @tilesize, @tilesize, @tilesize)
    end
    return unless @selected

    @graphics.lineStyle width: 2, color: '#000000'
    @graphics.drawRect(@selected[1] * @tilesize, @selected[0] * @tilesize, @tilesize, @tilesize)
    @graphics.lineStyle width: 1, color: '#93eacd'
    @graphics.lineStyle width: 2, color: '#93eacd'
    @graphics.beginFill '#93eacd', 0.6
    @graphics.drawRect(@selected[1] * @tilesize, @selected[0] * @tilesize, @tilesize, @tilesize)
    @graphics.endFill
  end

  def setup_cursor_events
    @app.stage.eventMode = 'static'
    @app.stage.on('mousemove') do |evt|
      evt = Native evt
      @hover = [(evt.globalY / @tilesize).to_i, (evt.globalX / @tilesize).to_i]
    end
    @app.stage.on('mouseout') do |evt|
      evt = Native evt
      @hover = false
    end

    @app.stage.on('click') do |_evt|
      @selected = @hover.map(&:clone)
    end
  end
end

class MapEditor
  def initialize(_map_width = 20, _map_height = 20, tilesize = 32)
    @ts = tilesize
    setup_tabs
    setup_canvas
  end

  def setup_tabs
    Element.find('.map-editor__selection__tabs > *').on :click do |e|
      target = e.current_target
      unless target.has_class? 'on'
        target.add_class('on').siblings('.on').remove_class('on')
        url = target.attr('data-tile-url')
        id = target.attr('data-tile-id')
        @tile_selector.load_tilemap(url, id)
      end
    end
  end

  def setup_canvas
    @tile_selector = TileSelector.new
    @tile_selector.load_tilemap('assets/tile.png', 1)
    Element.find('#map_editor__tiles').append @tile_selector.view.to_n
    @map = PIXI::Application.new('#080808')
    @map_data = {
      name: 'teste'
    }
  end
end
MapEditor.new
