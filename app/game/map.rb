class Map
  def initialize(app)
    @base = PIXI::Container.new
    @colisions = []
    @tileset = []

    @layers = []
    3.times { @layers << PIXI::Container.new }
    @layers.each { |l| @base.add_child l }

    setup_map

    app.add_child @base
  end

  def add_tile
    tile = PIXI::Sprite.new('/assets/tile.png')
    tile.width = 32
    tile.height = 32
    tile.set_frame(5, 4)
    @layers[0].add_child tile
    tile
  end

  def setup_map
    @colisions = [
      [1, 1, 1, 1, 1, 1, 1, 1],
      [1, 0, 0, 0, 0, 0, 0, 1],
      [1, 0, 0, 0, 0, 0, 0, 1],
      [1, 0, 0, 0, 0, 0, 0, 1],
      [1, 1, 1, 1, 1, 1, 1, 1]
    ]
    @tileset = [
      [1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 1],
      [1, 1, 1, 1, 1, 1, 1, 1]
    ]
    @tileset.each_with_index do |arr, i|
      y = 32 * i
      arr.each_with_index do |_tile_i, j|
        tile = add_tile
        p tile
        tile.x = 32 * j
        tile.y = y
      end
    end
  end
end
