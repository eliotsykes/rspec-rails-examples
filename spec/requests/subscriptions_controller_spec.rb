require "rails_helper"

RSpec.describe "Subscription Controller", type: :request do

  context "New request" do

    it "returns new subscription page" do
      get "/subscriptions/new"
      expect(response).to have_http_status(:success)

      expect(response).to render_template(:new)
    end

  end

  context "Create request" do
    it "returns to pending subscription page" do
      params = { subscription: { email: "e@example.tld", start_on: "2014-12-31" } }
      post "/subscriptions", params

      expect(response).to have_http_status(:found)
      expect(response).to redirect_to(pending_subscriptions_path)
    end
  end

  context "Confirm request" do

    let(:token) { SecureRandom.hex(32) }
    let!(:subscription) { create(:subscription, confirmation_token: token) }
    let(:today) { Date.today.to_formatted_s(:long_ordinal) }

    it "returns to subscription confirmation page" do
      get "/subscriptions/#{token}/confirm"

      expect(response).to have_http_status(:success)
      expect(response.body).to include("Your subscription will start on #{today}, thank you!")
    end
  end

end
