require "rails_helper"

RSpec.describe NewsMailer, :type => :mailer do
  
  describe ".send_headlines(headlines:, to:)" do
    
    it "has expected subject when there are headlines" do
      mail = NewsMailer.send_headlines(
        headlines: ["Scaremongering Headline: Be Fearful!"],
        to: "newsguy@goodnews.tld"
      )
      expect(mail).to have_subject("Today's Headlines")
    end

    [nil, []].each do |no_headlines|
      
      it "has expected subject when there are no headlines '#{no_headlines.inspect}'" do
        NewsMailer.send_headlines(headlines: no_headlines, to: "newsguy@goodnews.tld")
        expect(open_last_email).to have_subject "No Headlines Today :-("
      end

    end

    it "sends from the default email" do
      mail = NewsMailer.send_headlines(headlines: nil, to: "newsguy@goodnews.tld")
      expect(mail).to be_delivered_from("e@rspec-rails-examples.tld")
    end

    it "sends to the given recipient" do
      mail = NewsMailer.send_headlines(headlines: nil, to: "newsguy@goodnews.tld")
      expect(mail).to be_delivered_to("newsguy@goodnews.tld")
    end

    it "calls the error-sensitive deliver_now!" do
      
      delivery = double
      expect(delivery).to receive(:deliver_now!).with(no_args)

      expect(NewsMailer)
        .to receive(:headlines)
        .with(headlines: ["Man Bites Dog!"], to: "newsguy@goodnews.tld")
        .and_return(delivery)

      NewsMailer.send_headlines(headlines: ["Man Bites Dog!"], to: "newsguy@goodnews.tld")
    end

    context "HTML body" do
      it "has the given headlines" do
        headlines = ["A headline", "Another headline"]
        mail = NewsMailer.send_headlines(headlines: headlines, to: "newsguy@goodnews.tld")

        headlines.each do |headline|
          html = %Q|<li>#{headline}</li>|
          expect(mail).to have_body_text(html)
        end
      end

      it "contains no headline message when no headlines" do
        mail = NewsMailer.send_headlines(headlines: [], to: "newsguy@goodnews.tld")
        expect(mail).to have_body_text("<p>Sorry, no headlines. Better luck next time.</p>")
      end
    end

    context "plain text body" do
      it "has the given headlines" do
        headlines = ["A headline", "Another headline"]
        mail = NewsMailer.send_headlines(headlines: headlines, to: "newsguy@goodnews.tld")

        headlines.each do |headline|
          expect(mail.text_part).to have_body_text("- #{headline}")
        end
      end

      it "contains no headline message when no headlines" do
        mail = NewsMailer.send_headlines(headlines: [], to: "newsguy@goodnews.tld")
        expect(mail.text_part).to have_body_text("Sorry, no headlines. Better luck next time.")
      end
    end

  end
end
