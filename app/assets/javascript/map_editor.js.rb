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

class MapEditor
  def initialize(_map_width = 20, _map_height = 20, tilesize = 32)
    @ts = tilesize
    @tile_selector = PIXI::Application.new('#080808')
    setup_tabs
  end

  def setup_tabs
    Element.find('.map-editor__selection__tabs > *').on :click do |e|
      e.current_target.add_class("on").siblings(".on").remove_class("on")
    end
  end
end
MapEditor.new
