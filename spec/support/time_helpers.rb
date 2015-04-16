# Use Rails-provided test helper methods instead of Timecop:

# 0. Check spec/support dir is auto-required in spec/rails_helper.rb.
#
# 1. Create a file like this one you're reading in spec/support/time_helpers.rb:
RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers
end

# Suggested docs
# --------------
# http://api.rubyonrails.org/classes/ActiveSupport/Testing/TimeHelpers.html