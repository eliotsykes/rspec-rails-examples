# It's important that the matcher is in a module and the module
# has an instance method that will be available to the specs.
# The module name here will need to match the module name
# in the configuration specified in spec/support/matchers.rb
module Matchers

  # This instance method is what will be called in the specs
  # e.g. expect(page).to be_pending_subscription_page
  # 
  # This method is made available thanks to the
  # 'config.include Matchers ...' line in 
  #  spec/support/matchers.rb
  def be_pending_subscription_page(*args)
    BePendingSubscriptionPage.new(*args)
  end
  
  class BePendingSubscriptionPage
    include ::Rails.application.routes.url_helpers # Include _path & _url helpers

    # failure_message is a required method for RSpec matchers
    attr_accessor :failure_message

    # matches? is a required method for RSpec matchers
    def matches?(actual_page)
      expected_title = "Check your inbox"
      unless actual_page.has_title?(expected_title)
        self.failure_message = "\nexpected title: '#{expected_title}'\n     got title: '#{actual_page.title}'\n"
        return false
      end

      # pending_subscriptions_path is available here thanks to
      # including ::Rails.application.routes.url_helpers in this
      # class.
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

end
