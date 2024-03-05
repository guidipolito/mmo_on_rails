class Grid
  extend Native::Helpers
  attr_reader :lines
  attr_reader :cols
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
    @on_load_method = false
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
    return unless img_width != 0

    after_load
  end

  def update_grid
    return unless @map_texture

    @cols = (img_width / @tilesize).ceil
    @lines = (img_height / @tilesize).ceil
  end

  def after_load(*_args)
    width = img_width
    height = img_height
    @app.view.width = width
    @app.view.height = height
    @sprite = @tilemap_container.add_child PIXI::Sprite.new(texture: @map_texture)
    update_grid
    if @on_load_method != false
      @on_load_method.call
    end
  end

  def on_load(&block)
    @on_load_method = block
  end

  def draw_rect(cord, size = [1, 1])
    x = cord[0] * @tilesize
    y = cord[1] * @tilesize
    width = size[0] * @tilesize
    height = size[1] * @tilesize
    @graphics.drawRect(x, y, width, height)
  end

  # Returns array with [cord, size]
  def selection_range
    x = [@selection[0], @selection_end[0]]
    y = [@selection[1], @selection_end[1]]
    cord = [x.min, y.min]
    size = [x.max - x.min + 1, y.max - y.min + 1]
    [cord, size]
  end

  def draw_selection(range)
    return draw_rect(@selection) if @selection == @selection_end || !@selection_end

    range = selection_range
    draw_rect(range[0], range[1])
  end

  def grid_style(cord)
    @graphics.lineStyle width: 1, color: '#FFFFFF'
    draw_rect cord
  end

  def hover_style(cord)
    @graphics.lineStyle width: 4, color: '#000000'
    draw_rect cord
    @graphics.lineStyle width: 2, color: '#93eacd'
    draw_rect cord
  end

  def selection_style(range)
    @graphics.lineStyle width: 4, color: '#000000'
    draw_selection range
    @graphics.lineStyle width: 1, color: '#93eacd'
    @graphics.lineStyle width: 2, color: '#93eacd'
    @graphics.beginFill '#93eacd', 0.6
    draw_selection range
    @graphics.endFill
  end

  def draw_grid
    @graphics.clear
    @lines.times do |line|
      @cols.times do |col|
        grid_style([col, line])
      end
    end
    hover_style(@hover) if @hover
    selection_style(selection_range) if @selection
  end

  def on_selection_end; end

  def setup_cursor_events
    @app.stage.eventMode = 'static'
    @app.stage.on('mousemove') do |evt|
      evt = Native evt
      @hover = [(evt.globalX / @tilesize).to_i, (evt.globalY / @tilesize).to_i]
      @selection_end = @hover.map(&:clone) if @pressing_down && @hover
    end
    @app.stage.on('mouseout') do
      on_selection_end if @pressing_down
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
      on_selection_end
    end
  end

  attr_reader :tilesize

  def tilesize=(n)
    @tilesize = n
    update_grid
  end

  def img_width
    @map_texture.img_width
  end

  def img_height
    @map_texture.img_height
  end
end
