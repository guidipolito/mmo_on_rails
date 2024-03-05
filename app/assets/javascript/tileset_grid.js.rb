class TilesetGrid < Grid
  attr_accessor :selections
  attr_accessor :can_remove
  def initialize
    super
    @selections = []
    @on_update_method = nil
    @can_remove = false 
  end

  def tile_in_selection(cord)
    @selections[cord[1]][cord[0]] == true
  end

  def grid_style(cord)
    @graphics.lineStyle width: 1, color: '#FFFFFF', alpha: 0.1
    if @hover != cord
      @graphics.beginFill '#000000', 0.5
    else
      @graphics.beginFill '#000000', 0.1
    end
    if tile_in_selection cord
      @graphics.beginFill '#000000', 0
    end
    draw_rect cord
  end

  def hover_style(*args); end

  def on_selection_end
    range = selection_range
    selection_change = []
    range[1][0].times do |width|
      range[1][1].times do |height|
        x = range[0][0] + width 
        y = range[0][1] + height
        selection_change << [x, y]
        if @can_remove
          @selections[y][x] = !@selections[y][x]
        else
          @selections[y][x] = true
        end
      end
    end
    @selection = false
    @selection_end = false
    @on_update_method.call(@selections) unless @on_update_method.nil?
  end

  def on_update(&block)
    @on_update_method = block
  end
end
