module StripeHelper

  def fill_in_with_force(locator, options)
    page.execute_script "$('#{locator}').val('#{options[:with]}');"
  end

  alias_method :fill_in_stripe_field, :fill_in_with_force

end

RSpec.configure do |config|
  config.include StripeHelper, type: :feature
end
