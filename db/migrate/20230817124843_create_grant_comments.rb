class CreateGrantComments < ActiveRecord::Migration[6.1]
  def change
    create_table :grant_comments do |t|
      t.integer :user_id
      t.integer :grant_id
      t.string :comment

      t.timestamps
    end
  end
end
