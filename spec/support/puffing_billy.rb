# Installing Puffing Billy:

# 1. Puffing Billy depends on Capybara. Install Capybara as explained
#    in spec/support/capybara.rb
# 
# 2. Add puffing-billy to Gemfile:
#
# group :test do
#   gem 'puffing-billy'
# end
# 
# 3. Create a file like this one you're reading in spec/support/puffing_billy.rb:
require 'billy/rspec'

Billy.configure do |c|
  c.cache = true
  c.cache_request_headers = false
  c.ignore_params = ["http://www.google-analytics.com/__utm.gif",
                     "https://r.twimg.com/jot",
                     "http://p.twitter.com/t.gif",
                     "http://p.twitter.com/f.gif",
                     "http://www.facebook.com/plugins/like.php",
                     "https://www.facebook.com/dialog/oauth",
                     "http://cdn.api.twitter.com/1/urls/count.json"]
  c.path_blacklist = []
  c.merge_cached_responses_whitelist = []
  c.persist_cache = true
  c.ignore_cache_port = true # defaults to true
  c.non_successful_cache_disabled = false
  c.non_successful_error_level = :warn
  c.non_whitelisted_requests_disabled = false
  c.cache_path = 'spec/req_cache/'
end

# 4. Uncomment the *_billy driver for your desired browser:
# Capybara.javascript_driver = :selenium_billy # Uses Firefox
# Capybara.javascript_driver = :webkit_billy
# Capybara.javascript_driver = :poltergeist_billy
Capybara.register_driver :selenium_chrome_billy do |app|
  Capybara::Selenium::Driver.new(
    app, :browser => :chrome,
    :switches => [
        "--proxy-server=#{Billy.proxy.host}:#{Billy.proxy.port}"
        # "--ignore-certificate-errors" # May be needed in future
      ]
  )
end
Capybara.javascript_driver = :selenium_chrome_billy

# 5. Start using Puffing Billy. See spec/features/share_page_spec.rb for an example.


# Suggested docs
# --------------
# https://github.com/oesmith/puffing-billy
# https://github.com/oesmith/puffing-billy#rspec-usage

