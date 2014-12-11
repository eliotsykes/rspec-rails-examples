require "rails_helper"

RSpec.describe SubscriptionMailer, :type => :mailer do
  include EmailSpec::Matchers

  describe ".send_confirmation_request!(subscription)" do

    before do
      @subscription = Subscription.create!(
        email: "subscriber@foo.tld",
        confirmation_token: "this-is-a-confirmation-token"
      )
    end

    it "calls the error-sensitive deliver_now!" do
      delivery = double
      expect(delivery).to receive(:deliver_now!)

      expect(SubscriptionMailer)
        .to receive(:confirmation_request)
        .with(@subscription)
        .and_return(delivery)

      SubscriptionMailer.send_confirmation_request!(@subscription)
    end

    it "has appropriate subject" do
      mail = SubscriptionMailer.send_confirmation_request!(@subscription)
      expect(mail).to have_subject("Please confirm")
    end

    it "sends from the default email" do
      mail = SubscriptionMailer.send_confirmation_request!(@subscription)
      expect(mail).to be_delivered_from("e@rspec-rails-examples.tld")
    end

    it "sends to the subscriber" do
      mail = SubscriptionMailer.send_confirmation_request!(@subscription)
      expect(mail).to be_delivered_to("subscriber@foo.tld")
    end

    context "HTML body" do
      it "includes the confirm link" do
        mail = SubscriptionMailer.send_confirmation_request!(@subscription)
        anchor_html = %Q|<a href="#{confirm_subscription_url(@subscription)}">Confirm your subscription</a>|
        expect(mail).to have_body_text(anchor_html)
      end
    end

    context "plain text body" do
      it "includes the confirm URL" do
        mail = SubscriptionMailer.send_confirmation_request!(@subscription)
        expect(mail).to have_body_text(confirm_subscription_url(@subscription))
      end
    end
  end

end
