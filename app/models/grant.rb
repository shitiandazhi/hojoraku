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
end