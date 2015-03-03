class NewsMailer < ApplicationMailer

  def self.send_headlines(headlines:, to:)
    headlines(headlines: headlines, to: to).deliver_now!
  end

  def headlines(headlines:, to:)
    @headlines = headlines
    mail to: to,
      subject: headlines.blank? ?  "No Headlines Today :-(" : "Today's Headlines"
  end

end
