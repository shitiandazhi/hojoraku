class CreateGrantTags < ActiveRecord::Migration[6.1]
  def change
    create_table :grant_tags do |t|
      t.integer :tag_id
      t.integer :grant_id

      t.timestamps
    end
  end
end
