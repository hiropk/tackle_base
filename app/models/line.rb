class Line < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 50 }
  validates :brand, presence: true, length: { maximum: 50 }
  validates :pe_rating, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :length, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 2000 }
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :notes, length: { maximum: 1000 }

  enum :strand_count, { strand_count_none: 0, four: 1, eight: 2, twelve: 3, other: 4 }

  def self.ransackable_attributes(auth_object = nil)
    [ "brand", "created_at", "id", "length", "marker", "name", "notes", "pe_rating", "price", "purchase_date", "strand_count", "updated_at", "user_id" ]
  end
end
