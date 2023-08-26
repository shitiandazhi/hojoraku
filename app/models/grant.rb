class Grant < ApplicationRecord
belongs_to :user
belongs_to :tag

has_many :favorites, dependent: :destroy
has_many :grant_comments, dependent: :destroy
has_many :grant_tags, dependent: :destroy
has_one_attached :image

def favorited_by?(user)
  user.present? && favorites.exists?(user_id: user.id)
end

def self.looks(search, word)
    if search == "perfect_match"
      @grant = Grant.where("name LIKE?","#{word}")
    elsif search == "forward_match"
      @grant = Grant.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @grant = Grant.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @grant = Grant.where("name LIKE?","%#{word}%")
    else
      @grant = Grant.all
    end
end

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }
end