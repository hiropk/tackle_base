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
  validates :email_address, presence: true, uniqueness: true

  before_create :generate_activation_token
  after_create :send_activation_email

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  private

  def generate_activation_token
    self.activation_token = SecureRandom.urlsafe_base64
  end

  def send_activation_email
    UserMailer.activation_email(self).deliver_later
  end
end
