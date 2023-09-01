class AddTagIdToGrants < ActiveRecord::Migration[6.1]
  def change
    add_column :grants, :tag_id, :integer
  end
end
