# Installing Capybara:

# 0. Check spec/support dir is auto-required in spec/rails_helper.rb.
#
# 1. Add these to your Gemfile:
#
# group :development, :test do
#  gem 'capybara'
#  gem 'selenium-webdriver' # For Firefox
#  # gem 'chromedriver-helper' # Install to use Chrome in feature specs
# end
#
# 2. Create a file like this one you're reading in spec/support/capybara.rb:

require 'capybara/rails'
require 'capybara/rspec'

# By default Capybara will use Selenium+Firefox for `js:true` feature specs.
# Only if you're not using Puffing Billy, to use Chrome instead of Firefox,
# uncomment the following 3 lines:
# Capybara.register_driver :selenium do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end

# 3. Start using Capybara. See feature specs in this project for examples.

# Suggested docs
# --------------
# http://www.rubydoc.info/github/jnicklas/capybara/master
# Cheatsheet: https://gist.github.com/zhengjia/428105
# Capybara matchers: http://www.rubydoc.info/github/jnicklas/capybara/master/Capybara/Node/Matchers