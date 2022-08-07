class CreateGroupRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :group_requests do |t|
      t.integer :user_id
      t.integer :group_id
      t.integer :inviter_id
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
