class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.integer :reply_id
      t.integer :group_id
      t.text :content

      t.timestamps
    end
  end
end