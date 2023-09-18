class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :grants, dependent: :destroy
  has_many :grant_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_one_attached :profile_image

  validates :company_from, presence: true
  validates :name, presence: true
  validates :name_kana, presence: true
  validates :email, presence: true
  validates :post_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :phonenumber, presence: true


  def active_for_authentication?
    super && (is_deleted == false)
  end

  GUEST_USER_EMAIL = "guest@guest"
  GUEST_USER_NAME = "guest"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.company_from = "Guest Company"  # 会社名を設定
      user.name = "Guest Name"  # 名前を設定
      user.name_kana = "ゲストナマエ"  # 名前（カナ）を設定
      user.post_code = "1234567"  # 郵便番号を設定
      user.address = "Guest Address"  # 住所を設定
      user.phonenumber = "1234567890"  # 電話番号を設定
     end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
end

