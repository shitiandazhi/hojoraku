class AddStarToGrants < ActiveRecord::Migration[6.1]
  def change
    add_column :grants, :star, :string
  end
end
