class AddAccessControlToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :access_control, :integer, default: 0
  end
end
