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
      params = { subscription: { email: "e@example.tld", start_on: "2014-12-31" } }
      post :create, params

      expect(response).to redirect_to(pending_subscriptions_path)
    end

    it "calls Subscription.create_and_request_confirmation(params)" do
      email = "e@example.tld"
      start_on = "2015-02-28"

      expect(Subscription).to receive(:create_and_request_confirmation)
        .with({ email: email, start_on: start_on })

      post :create, { subscription: { email: email, start_on: start_on } }
    end

    it "raises an error if missing params email" do
      params = { subscription: { start_on: "2015-09-28" } }

      expect do
        post :create, params
      end.to raise_error ActiveRecord::RecordInvalid
    end

  end

  context "GET confirm" do

    it "confirms the subscription" do
      subscription = create(:subscription,
        email: "e@e.tld",
        confirmation_token: Subscription.generate_confirmation_token
      )
      expect(subscription.confirmed?).to eq(false)

      params = { confirmation_token: subscription.confirmation_token }
      get :confirm, params

      expect(subscription.reload.confirmed?).to eq(true)
      expect(assigns(:subscription)).to eq(subscription)
    end

    it "responds with 404 Not Found for unknown confirmation token" do
      params = { confirmation_token: "an-unknown-token" }
      expect do
        get :confirm, params
      end.to raise_error ActiveRecord::RecordNotFound
    end

  end

end
