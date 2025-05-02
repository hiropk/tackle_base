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
  before_create :generate_activation_token
  after_create :send_activation_email
  after_create :generate_profile

  validates :email_address, presence: true, uniqueness: { message: "はすでに使われています" }, length: { maximum: 70 }
  validates :password, presence: true, format: {
    with: /\A(?=.*[A-Z])(?=.*\d).{8,}\z/,
    message: "は8文字以上で、アルファベットの大文字と数字を含めてください。"
  }

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

  def generate_profile
    Profile.create(user: self, last_name: "名", first_name: "設定してください", residence: :shimane, fishing_areas: [ 31 ], interest_fishings: [ 0 ])
  end
end
