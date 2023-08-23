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


end
