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
      params = { subscription: { email: 'e@example.tld' } }
      post :create, params

      expect(response).to redirect_to(pending_subscriptions_path)
    end
  end


end
