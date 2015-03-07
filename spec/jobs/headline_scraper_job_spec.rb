require 'rails_helper'

RSpec.describe HeadlineScraperJob, :type => :job do
  
  it "emails headlines scraped from given URL" do
    
    url_to_scrape = "https://eliotsykes.github.io/rspec-rails-examples/"
    recipient_email = "anchor@nightlynews.tld"

    assert_performed_with(
      job: HeadlineScraperJob,
      args: [{url: url_to_scrape, recipient: recipient_email}], 
      queue: 'default'
    ) do

      VCR.use_cassette("news_page") do
        HeadlineScraperJob.perform_later url: url_to_scrape, recipient: recipient_email
      end

    end

    open_email recipient_email, with_subject: "Today's Headlines"
    

    expected_headlines = [
      # Original headline edited to prove VCR is serving scraped page.
      "Man Bites Dog (served by VCR)",
      "Dog Presses Charges",
      "Cat Dismissed as Unreliable Witness"
    ]

    expected_headlines.each do |expected_headline|
      expect(current_email).to have_body_text expected_headline
    end
    
  end

end
