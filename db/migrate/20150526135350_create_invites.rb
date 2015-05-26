class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :email, null: false
      t.string :token, null: false

      t.timestamps null: false
    end
    add_index :invites, :email, unique: true
    add_index :invites, :token, unique: true
  end
end
