# Installing Puffing Billy:

# 0. Check spec/support dir is auto-required in spec/rails_helper.rb.
#
# 1. Puffing Billy depends on Capybara. Install Capybara as explained
#    in spec/support/capybara.rb
#
# 2. Add puffing-billy to Gemfile:
#
# group :development, :test do
#   gem 'puffing-billy'
# end
#
# 3. Create a file like this one you're reading in spec/support/puffing_billy.rb:
require 'billy/rspec'

# 4. Configure cache to behave as required. See all available options at:
#    https://github.com/oesmith/puffing-billy#caching
Billy.configure do |c|
  c.cache = true
  c.cache_request_headers = false
  c.ignore_params = [
    'https://checkout.stripe.com/v3/0gSHV35gmU4Tq7Rgurt2A.html',
    'https://q.stripe.com/',
    'https://api.stripe.com/v1/tokens'
  ]
  c.persist_cache = true
  c.non_successful_cache_disabled = false
  c.non_successful_error_level = :warn

  # cache_path is where responses from external URLs will be saved as YAML.
  c.cache_path = "spec/support/http_cache/frontend/"

  # Avoid having tests dependent on external URLs.
  #
  # Only set non_whitelisted_requests_disabled **temporarily**
  # to false when first recording a 3rd party interaction. After
  # the recording has been stored to cache_path, then set
  # non_whitelisted_requests_disabled back to true.
  #
  # To enable recording new responses temporarily, run the individual spec
  # and prepend with BILLY_RECORDING set to true:
  # BILLY_RECORDING=true bin/rspec spec/features/user_upgrades_spec.rb
  prevent_recording = ('true' != ENV['BILLY_RECORDING'])
  c.non_whitelisted_requests_disabled = prevent_recording
end

# https://github.com/oesmith/puffing-billy#working-with-vcr-and-webmock
if defined?(VCR)
  VCR.configure do |config|
    config.ignore_request { |request| handled_by_billy?(request) }
  end

  def handled_by_billy?(request)
    # browser_referer?(request)
    browser_user_agent?(request) && browser_test_in_progress?
  end

  def browser_user_agent?(request)
    user_agent = !request.headers["User-Agent"].blank? && request.headers["User-Agent"].first
    user_agent != "Ruby"
  end

  def browser_test_in_progress?
    Capybara.current_driver != :rack_test
  end

  # def allowed_referers
  #   [
  #     %r{\Ahttp://#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}/},
  #     %r{\Ahttps://checkout\.stripe\.com},
  #     %r{\Ahttps://b\.stripecdn\.com}
  #   ]
  # end

  # def browser_referer?(request)
  #   referer = !request.headers["Referer"].blank? && request.headers["Referer"].first
  #   referer && allowed_referers.any? { |pattern| pattern =~ referer }
  # end
end

# 5. Uncomment the *_billy driver for your desired browser:
Capybara.javascript_driver = :selenium_billy # Uses Firefox
# Capybara.javascript_driver = :selenium_chrome_billy
# Capybara.javascript_driver = :webkit_billy
# Capybara.javascript_driver = :poltergeist_billy

# 6. Start using Puffing Billy. See spec/features/share_page_spec.rb for an example,
#    and find your cached responses in spec/support/http_cache/frontend

# Suggested docs
# --------------
# https://github.com/oesmith/puffing-billy
# https://github.com/oesmith/puffing-billy#rspec-usage
# https://github.com/oesmith/puffing-billy#caching
