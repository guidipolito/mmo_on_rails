class Tileset < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [200, 200]
  end

  validates :name, presence: true
  validates :tilesize, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :image, content_type: ['image/png', 'image/jpeg', 'image/jpg']
end
