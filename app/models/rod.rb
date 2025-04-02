class Rod < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    [ "brand", "created_at", "fishing_type", "id", "length", "max_weight", "min_weight", "name", "notes", "power", "purchase_date", "reel_type", "updated_at" ]
  end
end
