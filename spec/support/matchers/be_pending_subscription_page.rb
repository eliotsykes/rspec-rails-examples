class BePendingSubscriptionPage
  include ::Rails.application.routes.url_helpers

  attr_accessor :failure_message

  def matches?(actual_page)
    expected_title = "Check your inbox"
    if actual_page.has_no_title?(expected_title)
      self.failure_message = "\nexpected title: #{expected_title}\n     got title: #{actual_page.title}\n"
      return false
    end

    expected_path = pending_subscriptions_path
    if actual_page.current_path != expected_path
      self.failure_message = "\nexpected current path: #{expected_path}\n     got current path: #{actual_page.current_path}\n"
      return false
    end

    expected_content = "Please check your inbox and click the confirmation link to complete your subscription."
    if actual_page.has_no_content?(expected_content)
      self.failure_message = "\nexpected content: #{expected_content}\n     got content: #{actual_page.text}\n"
      return false
    end

    true
  end

end

def be_pending_subscription_page(*args)
  BePendingSubscriptionPage.new(*args)
end