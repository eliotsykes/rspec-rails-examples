module Matchers

  def be_confirm_subscription_page(expected_subscription)
    BeConfirmSubscriptionPage.new(expected_subscription)
  end

  class BeConfirmSubscriptionPage
    include ::Rails.application.routes.url_helpers

    attr_accessor :failure_message

    def initialize(expected_subscription)
      @expected_subscription = expected_subscription
    end

    def matches?(actual_page)

      expected_title = "Subscription confirmed!"
      if actual_page.has_no_title?(expected_title)
        self.failure_message = "\nexpected title: #{expected_title}\n     got title: #{actual_page.title}\n"
        return false
      end

      expected_path = confirm_subscription_path(@expected_subscription)
      if actual_page.current_path != expected_path
        self.failure_message = "\nexpected current path: #{expected_path}\n     got current path: #{actual_page.current_path}\n"
        return false
      end

      if @expected_start_on
        expected_content = "Your subscription will start on #{@expected_start_on}, thank you!"
        if actual_page.has_no_content?(expected_content)
          self.failure_message = "\nexpected content: #{expected_content}\n     got content: #{actual_page.text}\n"
          return false
        end
      end
      
      true
    end

    # Chainable method to allow this kind of use:
    # expect(page).to be_confirm_subscription_page(subscription).with_subscription_starting_on("February 29th, 2008")
    def with_subscription_starting_on(expected_start_on)
      @expected_start_on = expected_start_on
      self # To be chainable this method returns self
    end

  end

end
