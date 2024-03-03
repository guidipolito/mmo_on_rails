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
  # selection:: false or [x, y] of selection
  # selection_end:: false or [x, y] after mouse_up or leaving the canvas, used for calc x,y,width,height
  # map_texture:: the texture loaded in the canvas, used to get width and height
  # url_loaded:: last url loaded
  # tilemap_id:: the id the map should use when inserting the selected tile
  # sprite:: last sprite loaded
  # tilemap_container:: keep sprite below the grid
  # grid_container:: keep grid made by graphics above
  # hover:: array with line and col being hovered
  # tilesize:: Integer of the size in pixels each square have
  def initialize
    @selection = false # can be [int, int]
    @selection_end = false
    @pressing_down = false
    @hover = false

    @app = PIXI::Application.new('#080808')
    `window.__PIXI_APP__ = #{@app.to_n}`
    @map_texture = false
    @url_loaded = false
    @id = false
    @sprite = false
    @tilemap_container = @app.add_child PIXI::Container.new
    @grid_container = @app.add_child PIXI::Container.new
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
    return unless @map_texture.img_width != 0

    after_load
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

  def draw_rect(cord, size = [1, 1])
    x = cord[0] * @tilesize
    y = cord[1] * @tilesize
    width = size[0] * @tilesize
    height = size[1] * @tilesize
    @graphics.drawRect(x, y, width, height)
  end

  def draw_selection
    return unless @selection
    return draw_rect(@selection) if @selection == @selection_end || !@selection_end

    x = [@selection[0], @selection_end[0]]
    y = [@selection[1], @selection_end[1]]
    size = [x.max - x.min + 1, y.max - y.min + 1]
    cord = [x.min, y.min]
    draw_rect(cord, size)
  end

  def draw_grid
    @graphics.clear
    @lines.times do |line|
      @cols.times do |col|
        @graphics.lineStyle width: 1, color: '#FFFFFF'
        draw_rect([col, line])
      end
    end
    if @hover
      @graphics.lineStyle width: 4, color: '#000000'
      draw_rect @hover
      @graphics.lineStyle width: 2, color: '#93eacd'
      draw_rect @hover
    end
    return unless @selection

    @graphics.lineStyle width: 4, color: '#000000'
    draw_selection
    @graphics.lineStyle width: 1, color: '#93eacd'
    @graphics.lineStyle width: 2, color: '#93eacd'
    @graphics.beginFill '#93eacd', 0.6
    draw_selection
    @graphics.endFill
  end

  def setup_cursor_events
    @app.stage.eventMode = 'static'
    @app.stage.on('mousemove') do |evt|
      evt = Native evt
      @hover = [(evt.globalX / @tilesize).to_i, (evt.globalY / @tilesize).to_i]
      @selection_end = @hover.map(&:clone) if @pressing_down && @hover
    end
    @app.stage.on('mouseout') do
      @pressing_down = false
      @hover = false
    end
    @app.stage.on('mousedown') do
      @selection = @hover.map(&:clone)
      @selection_end = @selection
      @pressing_down = true
    end
    @app.stage.on('mouseup') do
      @pressing_down = false
    end
  end
end

# WIP
# class TileData
# end
# 
# class TilesetData
#   def initialize
#   end
# end

class MapBuilder
  def initialize(size_x=50, size_y=50, tilesize=48)
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

  def setup_map_builder
  end
end
MapEditor.new
