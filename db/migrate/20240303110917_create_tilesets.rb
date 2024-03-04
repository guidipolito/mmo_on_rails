class CreateTilesets < ActiveRecord::Migration[7.0]
  def change
    create_table :tilesets do |t|
      t.string :name
      t.integer :tilesize
      t.json :tiles

      t.timestamps
    end
  end
end
