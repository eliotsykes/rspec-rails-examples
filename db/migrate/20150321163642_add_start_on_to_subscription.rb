class AddStartOnToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :start_on, :date
  end
end
