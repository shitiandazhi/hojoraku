class Tag < ApplicationRecord

  has_many :grants, dependent: :destroy

validates :name, presence: true

  def self.looks(search, word)
    if search == "perfect_match"
      @tag = Tag.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @tag = Tag.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @tag = Tag.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @tag = Tag.where("name LIKE?","%#{word}%")
    else
      @tag = Tag.all
    end
  end

end
