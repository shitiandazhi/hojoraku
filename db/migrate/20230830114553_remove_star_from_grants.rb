class RemoveStarFromGrants < ActiveRecord::Migration[6.1]
  def change
    remove_column :grants, :name, :string
  end
end
