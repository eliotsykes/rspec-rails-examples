require "rails_helper"

RSpec.describe "routes for Subscriptions", :type => :routing do

  context "confirm_subscription route" do

    it "should use the confirmation token as the identifier" do

      subscription = Subscription.create!(confirmation_token: "im-a-token-98765")

      expect(:get => confirm_subscription_path(subscription))
      .to route_to(
        controller: "subscriptions",
        action: "confirm",
        confirmation_token: "im-a-token-98765"
      )
    end

  end

end
