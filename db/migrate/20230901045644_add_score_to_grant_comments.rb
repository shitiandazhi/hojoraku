class AddScoreToGrantComments < ActiveRecord::Migration[6.1]
  def change
    add_column :grant_comments, :score, :decimal, precision: 5, scale: 3
  end
end
