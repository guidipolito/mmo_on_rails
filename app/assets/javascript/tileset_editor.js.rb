class TilesetEditor
  def initialize
    @form_el = Element.find '#tileset-edit'
    @tilesize_el = @form_el.find('#tileset_tilesize')
    @tilesize = @tilesize_el.value.to_i
    @tilesize_el.on :keyup, &method(:bind_tilesize)
    @tilesize_el.on :change, &method(:bind_tilesize)
    @image_url = @form_el.attr('data-url')
    setup_tabs
    setup_canvas
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
    end
  end

  def setup_canvas
    @tile_selector = Grid.new
    @tile_selector.tilesize = @tilesize
    @tile_selector.load_tilemap(@image_url, 1)
    Element.find('#tileset-edit-canvas').append @tile_selector.view.to_n
  end

  def setup_map_builder; end
end

exists('#tileset-edit') { TilesetEditor.new }
