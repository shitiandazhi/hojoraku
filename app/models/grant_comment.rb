class GrantComment < ApplicationRecord

  belongs_to :user
  belongs_to :grant
end
