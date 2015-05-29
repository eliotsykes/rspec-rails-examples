# Installing email_spec:

# 0. Check spec/support dir is auto-required in spec/rails_helper.rb.
#
# 1. Add email_spec to Gemfile:
#
# group :test do
#  gem 'email_spec'
# end

# 2. Create a file like this one you're reading in spec/support/email_spec.rb:
require 'email_spec'

RSpec.configure do |config|

  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers

  config.before(:each) do
    reset_mailer # Clears out ActionMailer::Base.deliveries
  end

end

# 3. Start making use of email_spec helpers and matchers. See specs in this project
#    for examples.

# Suggested docs
# --------------
# https://github.com/bmabey/email-spec#rspec
# https://github.com/bmabey/email-spec#rspec-matchers
# http://www.rubydoc.info/gems/email_spec/EmailSpec/Helpers
# http://www.rubydoc.info/gems/email_spec/EmailSpec/Matchers
