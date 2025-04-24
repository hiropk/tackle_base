class User < ApplicationRecord
  has_secure_password
  has_one :profile, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :tackles, dependent: :destroy
  has_many :rods, dependent: :destroy
  has_many :reels, dependent: :destroy
  has_many :lines, dependent: :destroy
  has_many :leaders, dependent: :destroy
  has_many :logs, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase }
end
