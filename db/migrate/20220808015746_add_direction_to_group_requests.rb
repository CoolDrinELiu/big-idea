class AddDirectionToGroupRequests < ActiveRecord::Migration[7.0]
  def change
    add_column :group_requests, :direction, :integer, default: 0
  end
end
