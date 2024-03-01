
require 'pixi/pixi'
require 'element'
class MapEditor
  def initialize(_map_width = 20, _map_height = 20, tilesize = 32)
    @ts = tilesize
    @tile_selector = PIXI::Application.new('#1099bb')
    Element.new('#map_editor__tiles').add_child @tile_selector.view
  end
end
MapEditor.new
