require "tileset_grid"
class TilesetEditor
  def initialize
    @form_el = Element.find '#tileset-edit'
    @tilesize_el = @form_el.find('#tileset_tilesize')
    @tilesize = @tilesize_el.value.to_i
    @tilesize_el.on :keyup, &method(:bind_tilesize)
    @tilesize_el.on :change, &method(:bind_tilesize)
    @image_url = @form_el.attr('data-url')
    @tiles_field = @form_el.find("#tileset_tiles")
    @tiles = nil
    @selections = []
    @tab_selected = 0
    setup_tabs
    setup_canvas
    setup_canvas_on_load
    setup_on_update_canvas
  end

  def bind_tilesize(e)
    new_value = e.current_target.value.to_i
    return unless new_value.positive?

    @tilesize = new_value
    @tile_selector.tilesize = @tilesize
  end

  def setup_tabs
    Element.find('.map-editor__selection__tabs > *').on :click do |e|
      target = e.current_target
      target.add_class('on').siblings('.on').remove_class('on') unless target.has_class? 'on'
      update_tab target.index
    end
  end

  def setup_canvas
    @tile_selector = TilesetGrid.new
    @tile_selector.tilesize = @tilesize
    @tile_selector.load_tilemap(@image_url, 1)
    Element.find('#tileset-edit-canvas').append @tile_selector.view.to_n
  end

  def setup_canvas_on_load
    @tile_selector.on_load do 
      @tiles = JSON.parse(@tiles_field.value)
      raise "no tiles" if @tiles.nil? || @tiles == ""
      update_tab(0)
    rescue
      @tiles = []
      @tile_selector.lines.times do
        arr = []
        @tile_selector.cols.times do
          arr << { layer: 0, colision: false }
        end
        @tiles << arr
      end
      update_tab(0)
    end
  end

  def setup_on_update_canvas
    @tile_selector.on_update do |selections|
      selections.length.times do |line|
        selections[line].length.times do |col|
          if layer_tab?
            @tiles[line][col][:layer] = @tab_selected if selections[line][col]
          else
            @tiles[line][col][:colision] = selections[line][col]
          end
        end
      end
      @tiles_field.value = @tiles.to_json
    end
  end

  def layer_matrix(layer)
    @tiles.map{|arr| arr.map{|tile| tile[:layer] == layer }}
  end

  def colision_matrix
    @tiles.map{|arr| arr.map{|tile| tile[:colision] }}
  end

  def update_tab(n)
    @tab_selected = n
    if layer_tab?
      @tile_selector.selections = layer_matrix(n) 
      @tile_selector.can_remove = false
    end
    if n == 3
      @tile_selector.selections = colision_matrix 
      @tile_selector.can_remove = true
    end
  end

  def layer_tab?
    @tab_selected < 3
  end

  def setup_map_builder; end
end

exists('#tileset-edit') { TilesetEditor.new }
