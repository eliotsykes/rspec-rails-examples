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
      HeadlineScraperJob.perform_later url: url_to_scrape, recipient: recipient_email
    end

    open_email recipient_email, with_subject: "Today's Headlines"
    
    expected_headlines = [
      "Man Bites Dog",
      "Dog Presses Charges",
      "Cat Dismissed as Unreliable Witness"
    ]

    expected_headlines.each do |expected_headline|
      expect(current_email).to have_body_text expected_headline
    end
    
  end

end
