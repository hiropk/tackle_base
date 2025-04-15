class Reel < ApplicationRecord
  belongs_to :user
  belongs_to :line

  validates :name, presence: true, length: { maximum: 50 }
  validates :brand, presence: true, length: { maximum: 50 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :notes, length: { maximum: 1000 }

  enum :reel_type, { reel_type_none: 0, bait: 1, spining: 2, reel_type_other: 3 }
  enum :gear_type, { gear_type_none: 0, power_gear: 1, normal_gear: 2, high_gear: 3, extra_high_gear: 4, gear_type_other: 5 }

  def self.ransackable_attributes(auth_object = nil)
    [ "brand", "created_at", "gear_type", "id", "line_id", "name", "notes", "price", "purchase_date", "reel_type", "updated_at", "user_id" ]
  end
end
