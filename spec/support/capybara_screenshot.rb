# Installing capybara-screenshot:

# 0. Check spec/support dir is auto-required in spec/rails_helper.rb.
#
# 1. Add capybara-screenshot to Gemfile:
#
# group :test do
#   gem 'capybara-screenshot'
# end
#
# 2. Create a file like this one you're reading in spec/support/capybara-screenshot.rb:

require 'capybara-screenshot/rspec'

# Manual screenshot.
# This is useful if the failure occurs at a point where the
# screen shot is not as useful for debugging a rendering problem.

# Anywhere the Capybara DSL methods (visit, click etc.) are available so
# too are the screenshot methods. Defaults is true
# Capybara::Screenshot.autosave_on_failure = false

# Specify a custom screenshot size. Default is 1000px
# Capybara::Screenshot.webkit_options = { width: 1024, height: 768 }

# Custom screenshot file name for a specific test library.
# Capybara::Screenshot.register_filename_prefix_formatter(:rspec) do |example|
#   "screenshot_#{example.description.gsub(' ', '-').gsub(/^.*\/spec\//,'')}"
# end

# Disable time stamp in the basename. Defaults is true
# Capybara::Screenshot.append_timestamp = false

# Custom screenshot directory. Defaults is `$APPLICATION_ROOT/tmp/capybara`
# Capybara.save_and_open_page_path = "/your/file/path"

# Pruning old screenshot automatically. Defaults screenshots are saved indefinitely
#
# Keep only the screenshots generated from the last failing test suite
# Capybara::Screenshot.prune_strategy = :keep_last_run
#
# Keep up to the number of screenshots specified in the hash
# Capybara::Screenshot.prune_strategy = { keep: 10 }

# Disable the screenshots information for each failed spec. Defautls is enable
# Capybara::Screenshot::RSpec.add_link_to_screenshot_for_failed_examples = false
