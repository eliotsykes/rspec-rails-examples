# Use Rails-provided test helper methods:

# 0. Check spec/support dir is auto-required in spec/rails_helper.rb.
#
# 1. Create a file like this one you're reading in spec/support/job_helpers.rb:
RSpec.configure do |config|
  config.include ActiveJob::TestHelper, type: :job
end

# Suggested docs
# --------------
# http://api.rubyonrails.org/classes/ActiveJob/TestHelper.html