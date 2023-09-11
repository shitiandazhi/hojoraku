class AddCategoryToGrantComments < ActiveRecord::Migration[6.1]
  def change
    add_column :grant_comments, :category, :string
  end
end
