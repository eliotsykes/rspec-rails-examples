class AddRoleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :role, :string, default: "standard", null: false
  end
end
