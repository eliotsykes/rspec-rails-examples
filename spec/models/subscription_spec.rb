require 'rails_helper'

RSpec.describe Subscription, :type => :model do
  
  xcontext "attributes" do
    
    it "has email" do
    end

    it "has confirmed" do
      # defaults to false
    end

    it "has confirmation_token" do
    end

  end

  xcontext "validations" do
    
    it "validates email is unique" do
    end

    it "validates confirmation_token is unique" do
    end
  end

  context "#to_param" do
    
    it "uses confirmation_token as the default identifier for routes" do
      subscription = Subscription.new(confirmation_token: "hello-im-a-token-123")
      expect(subscription.to_param).to eq("hello-im-a-token-123")
    end

  end

  context "#create_and_request_confirmation!(email)" do
    
    it "creates an unconfirmed subscription" do
      email = "subscriber@somedomain.tld"
      Subscription.create_and_request_confirmation!(email)

      subscription = Subscription.first

      expect(subscription.email).to eq(email)
      expect(subscription.confirmed?).to eq(false)
    end

    it "saves subscription a secure random confirmation_token" do
      expect(::SecureRandom).to receive(:hex).with(32).and_call_original
      subscription = Subscription.create_and_request_confirmation!("hello@example.tld")
      subscription.reload
      
      expect(subscription.confirmation_token).to match /\A[a-z0-9]{64}\z/
    end

    it "emails a confirmation request" do
      expect(SubscriptionMailer)
        .to receive(:confirmation_request)
        .with(Subscription)
        .and_return( double(deliver_now: true) )
      
      email = "subscriber@somedomain.tld"
      
      Subscription.create_and_request_confirmation!(email)
    end

    xit "doesn't create subscription if emailing fails" do
    end

    xit "raises an error if the subscription isn't created" do
    end

    xit "raises an error if the emailing fails" do
    end

  end

  context ".confirm!(confirmation_token)" do
    
    it "confirms the subscription matching the confirmation_token" do
      token = Subscription.generate_confirmation_token
      subscription = Subscription.create!(
        email: "a@a.a", 
        confirmation_token: token
      )
      expect(subscription.confirmed?).to eq(false)

      Subscription.confirm!(token)
      expect(subscription.reload.confirmed?).to eq(true)
    end

    xit "gracefully handles confirming an already confirmed subscription" do
    end

    xit "raises error if confirmation_token is unknown" do
    end

  end

end
