class AddRoleToMembers < ActiveRecord::Migration[5.0]
  def change
    add_column :members, :role, :integer, null: false, default: 1
  end
end
