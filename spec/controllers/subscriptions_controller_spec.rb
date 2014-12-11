require 'rails_helper'

RSpec.describe SubscriptionsController, :type => :controller do

  context "GET new" do
    
    it "assigns a blank subscription to the view" do
      get :new
      expect(assigns(:subscription)).to be_a_new(Subscription)
    end

  end

  context "POST create" do
    
    it "redirects to pending subscriptions page" do
      params = { subscription: { email: "e@example.tld" } }
      post :create, params

      expect(response).to redirect_to(pending_subscriptions_path)
    end

    it "calls Subscription.create_and_request_confirmation!(email)" do
      email = "e@example.tld"
      expect(Subscription).to receive(:create_and_request_confirmation!).with email

      params = { subscription: { email: email } }
      post :create, params
    end

  end

  context "GET confirm" do
    
    it "confirms the subscription" do
      subscription = Subscription.create!(
        email: "e@e.tld", 
        confirmation_token: Subscription.generate_confirmation_token
      )
      expect(subscription.confirmed?).to eq(false)

      params = { confirmation_token: subscription.confirmation_token }
      get :confirm, params

      expect(subscription.reload.confirmed?).to eq(true)
    end

    xit "responds with 404 Not Found for unknown confirmation token" do
    end

  end

end
