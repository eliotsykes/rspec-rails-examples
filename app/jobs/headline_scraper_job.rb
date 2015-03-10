class HeadlineScraperJob < ActiveJob::Base
  include Capybara::DSL

  queue_as :default

  def perform(url:, recipient:)

    Capybara.default_driver = :poltergeist_billy

    headlines = []
    # page = Nokogiri::HTML(open(url))
    # headlines = page.css("section h1").map(&:text)

    visit url
    headlines = page.all("section h1").map(&:text)
    NewsMailer.send_headlines(headlines: headlines, to: recipient)
  end
end
