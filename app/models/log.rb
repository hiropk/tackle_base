class Log < ApplicationRecord
  has_many :tackle_selections, dependent: :destroy
  has_many :tackles, through: :tackle_selections
end
