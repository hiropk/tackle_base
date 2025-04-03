class Rod < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :brand, presence: true, length: { maximum: 50 }
  validates :max_weight, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 700 }
  validates :min_weight, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 300 }
  validates :length, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 20 }
  validates :notes, length: { maximum: 500 }

  enum :fishing_type, { fishing_type_none: 0, jiging: 1 }
  enum :power, { power_none: 0, hevy: 1, medium_hevy: 2, medium: 3, medium_light: 4, light: 5 }
  enum :reel_type, { reel_type_none: 0, bait: 1, spining: 2, other: 3 }

  def self.ransackable_attributes(auth_object = nil)
    [ "brand", "created_at", "fishing_type", "id", "length", "max_weight", "min_weight", "name", "notes", "power", "purchase_date", "reel_type", "updated_at" ]
  end
end
