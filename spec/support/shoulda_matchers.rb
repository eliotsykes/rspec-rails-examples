# Installing shoulda-matchers:

# 0. Check spec/support dir is auto-required in spec/rails_helper.rb.
#
# 1. Add shoulda-matchers to Gemfile:
#
# group :test do
#   gem 'shoulda-matchers', '3.0.0.rc1'
# end
#
# 2. Create a file like this one you're reading in spec/support/shoulda_matchers.rb:
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    
    # Choose one or more libraries:
    # with.library :active_record
    # with.library :active_model
    # with.library :action_controller
    # Or, choose the following (which implies all of the above):
    with.library :rails
  end
end

# 3. Start using shoulda-matchers. See specs in this project for examples.

# Suggested docs
# --------------
# https://gist.github.com/kyletcarlson/6234923
# https://github.com/thoughtbot/shoulda-matchers#rspec
# https://github.com/thoughtbot/shoulda-matchers#configuration
# https://github.com/thoughtbot/shoulda-matchers#activemodel-matchers
# http://thoughtbot.github.io/shoulda-matchers/
# http://thoughtbot.github.io/shoulda-matchers/docs/v3.0.0.rc1/
# http://thoughtbot.github.io/shoulda-matchers/docs/v3.0.0.rc1/Shoulda/Matchers/ActiveModel.html
# http://thoughtbot.github.io/shoulda-matchers/docs/v3.0.0.rc1/Shoulda/Matchers/ActiveRecord.html
