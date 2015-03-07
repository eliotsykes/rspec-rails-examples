# Installing Puffing Billy:

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
  c.persist_cache = true
  c.non_successful_cache_disabled = false
  c.non_successful_error_level = :warn

  # cache_path is where responses from external URLs will be saved as YAML.
  c.cache_path = "spec/support/http_cache/billy/"  

  # Avoid having tests dependent on external URLs.
  #
  # Only set non_whitelisted_requests_disabled **temporarily**
  # to false when first recording a 3rd party interaction. After
  # the recording has been stored to cache_path, then set
  # non_whitelisted_requests_disabled back to true.
  c.non_whitelisted_requests_disabled = true
end

# 5. Uncomment the *_billy driver for your desired browser:
# Capybara.javascript_driver = :selenium_billy # Uses Firefox
# Capybara.javascript_driver = :webkit_billy
# Capybara.javascript_driver = :poltergeist_billy
Capybara.register_driver :selenium_chrome_billy do |app|
  Capybara::Selenium::Driver.new(
    app, browser: :chrome,
    switches: [
        "--proxy-server=#{Billy.proxy.host}:#{Billy.proxy.port}"
        # "--ignore-certificate-errors" # May be needed in future
      ]
  )
end
Capybara.javascript_driver = :selenium_chrome_billy

# 6. Start using Puffing Billy. See spec/features/share_page_spec.rb for an example,
#    and find your cached responses in spec/support/http_cache/billy

# Suggested docs
# --------------
# https://github.com/oesmith/puffing-billy
# https://github.com/oesmith/puffing-billy#rspec-usage
# https://github.com/oesmith/puffing-billy#caching

