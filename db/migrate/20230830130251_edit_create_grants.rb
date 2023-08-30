class EditCreateGrants < ActiveRecord::Migration[6.1]
  def change
    create_table :grants do |t|
      t.integer :user_id
      t.string :name
      t.string :background
      t.string :body
      t.integer :application_status
      t.timestamps # この行を追加
    end
  end
end