class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :grants, dependent: :destroy
  has_many :grant_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :profile_image

  def active_for_authentication?
    super && (is_deleted == false)
  end

  GUEST_USER_EMAIL = "guest@guest"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end
end