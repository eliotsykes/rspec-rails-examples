require 'open-uri'

class HeadlineScraperJob < ActiveJob::Base
  queue_as :default

  def perform(url:, recipient:)
    headlines = []
    page = Nokogiri::HTML(open(url))
    headlines = page.css("section h1").map(&:text)
    NewsMailer.send_headlines(headlines: headlines, to: recipient)
  end
end
