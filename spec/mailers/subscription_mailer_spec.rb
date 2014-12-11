require "rails_helper"

RSpec.describe SubscriptionMailer, :type => :mailer do
  include EmailSpec::Matchers

  describe "confirmation_request" do

    before do
      @subscription = Subscription.create!(
        email: "subscriber@foo.tld",
        confirmation_token: "this-is-a-confirmation-token"
      )
      @mail = SubscriptionMailer.confirmation_request(@subscription)
    end

    it "has appropriate subject" do
      expect(@mail).to have_subject("Please confirm")
    end

    it "sends from the default email" do
      expect(@mail).to be_delivered_from("e@rspec-rails-examples.tld")
    end

    it "sends to the subscriber" do
      expect(@mail).to be_delivered_to("subscriber@foo.tld")
    end

    context "HTML body" do
      it "includes the confirm link" do
        anchor_html = %Q|<a href="#{confirm_subscription_url(@subscription)}">Confirm your subscription</a>|
        expect(@mail).to have_body_text(anchor_html)
      end
    end

    context "plain text body" do
      it "includes the confirm URL" do
        expect(@mail).to have_body_text(confirm_subscription_url(@subscription))
      end
    end
  end

end
