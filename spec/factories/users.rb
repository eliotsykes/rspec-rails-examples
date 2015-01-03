FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "user#{n}@example.tld" }
    password  "test password"

    before(:create) { |user| user.skip_confirmation! }
  end

end
