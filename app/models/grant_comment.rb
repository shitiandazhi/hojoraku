class GrantComment < ApplicationRecord

  belongs_to :user
  belongs_to :grant

  validates :comment, presence: true
end
