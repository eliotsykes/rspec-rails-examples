namespace :subscription do
  namespace :confirmation_overdue do
    
    desc "Delete subscriptions that have not been confirmed in time"
    task delete: :environment do
      Subscription.confirmation_overdue.destroy_all
    end

  end
end
