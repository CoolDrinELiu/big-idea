class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :content
      t.string :title
      t.integer :group_id

      t.timestamps
    end
  end
end
