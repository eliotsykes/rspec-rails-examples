# Use Rails-provided test helper methods instead of Timecop

RSpec.configure do |config|
  config.include ActiveSupport::Testing::TimeHelpers
end

# Suggested docs
# --------------
# http://api.rubyonrails.org/classes/ActiveSupport/Testing/TimeHelpers.html