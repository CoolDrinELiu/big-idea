class CreateUserGroupRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :user_group_relationships do |t|
      t.integer :group_id
      t.integer :user_id

      t.timestamps
    end

    add_index :user_group_relationships, :group_id
    add_index :user_group_relationships, :user_id
  end
end
