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
 class TileData
 end
 
 class TilesetData
   def initialize
     @name = ''
     @url = ""
     @id = 1
     @tilesize = 48
     @tiles = [
       [ { layer: 0, colision: true, frames_per_second: 5, frames: [[x,y], [x,y]] } ], # line 1
       [ { layer: 1, colision: false } ], # line 2, not animated tile
     ]
   end
 end

class MapBuilder
  def initialize(size_x = 50, size_y = 50, tilesize = 48); end
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
    @tile_selector = Grid.new
    @tile_selector.load_tilemap('assets/tile.png', 1)
    Element.find('#map_editor__tiles').append @tile_selector.view.to_n
    p Element.find('#map_editor__tiles')
    @map = PIXI::Application.new('#080808')
    @map_data = {
      name: 'teste'
    }
  end

  def setup_map_builder; end
end

exists("#map_editor__tiles"){ MapEditor.new }
