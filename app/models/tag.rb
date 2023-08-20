class Tag < ApplicationRecord

  has_many :pgrants, dependent: :destroy

end
