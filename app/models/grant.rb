class Grant < ApplicationRecord
  belongs_to :user
  belongs_to :tag

  has_many :favorites, dependent: :destroy
  has_many :grant_comments, dependent: :destroy
  has_many :grant_tags, dependent: :destroy
  has_one_attached :image

  validates :name, presence: true
  validates :background, presence: true
  validates :body, presence: true

  def favorited_by?(user)
    user.present? && favorites.exists?(user_id: user.id)
  end

  # メソッド名をself.searchと変更
  def self.looks(search, word)
    if search == "perfect_match"
      where("name LIKE ?", "#{word}")
    elsif search == "forward_match"
      where("name LIKE ?", "#{word}%")
    elsif search == "backward_match"
      where("name LIKE ?", "%#{word}")
    elsif search == "partial_match"
      where("name LIKE ?", "%#{word}%")
    else
      all
    end
  end

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_2day_ago, -> { where(created_at: 2.days.ago.all_day) } # 2日前
  scope :created_3day_ago, -> { where(created_at: 3.days.ago.all_day) } # 3日前
  scope :created_4day_ago, -> { where(created_at: 4.days.ago.all_day) } # 4日前
  scope :created_5day_ago, -> { where(created_at: 5.days.ago.all_day) } # 5日前
  scope :created_6day_ago, -> { where(created_at: 6.days.ago.all_day) } # 6日前
  scope :created_this_week, -> { where(created_at: 6.days.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.weeks.ago.beginning_of_day..1.week.ago.end_of_day) }
end