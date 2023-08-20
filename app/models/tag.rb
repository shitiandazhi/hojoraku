class Tag < ApplicationRecord

  has_many :grants, dependent: :destroy

end
