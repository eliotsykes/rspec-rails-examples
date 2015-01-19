FactoryGirl.define do
  
  factory :subscription do
    sequence(:email) { |n| "subscriber#{n}@test.tld" }
    confirmation_token { Subscription.generate_confirmation_token }
    confirmed false
  end

end
