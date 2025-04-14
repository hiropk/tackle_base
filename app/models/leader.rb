class Leader < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :brand, presence: true, length: { maximum: 50 }
  validates :leader_rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :length, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 2000 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :notes, length: { maximum: 1000 }

  enum :material, { material_none: 0, fluorocarbon: 1, nylon: 2, other: 3 }
end
