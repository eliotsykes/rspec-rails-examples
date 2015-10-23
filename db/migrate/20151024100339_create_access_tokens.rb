class CreateAccessTokens < ActiveRecord::Migration
  def change
    create_table :access_tokens do |t|
      t.string :locator, index: {unique: true}, null: false
      t.text :encrypted_secret, null: false
      t.belongs_to :user, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
