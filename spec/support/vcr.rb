# Installing VCR:

# 0. Check spec/support dir is auto-required in spec/rails_helper.rb.
#
# 1. Add vcr and webmock gems to Gemfile:
#
# group :test do
#   gem 'vcr'
#   gem 'webmock'
# end

# 2. Copy spec/support/webmock.rb into your project:
require_relative 'webmock'

# 3. Create a file like this one you're reading in spec/support/vcr.rb
VCR.configure do |config|
  # To enable recording new responses temporarily, run the individual spec
  # and prepend with RECORD set to true:
  # RECORD=true bin/rspec spec/features/user_upgrades_spec.rb
  record_mode = HttpRecord.on? ? :once : :none
  config.default_cassette_options = {
    decode_compressed_response: true,
    allow_unused_http_interactions: false,
    match_requests_on: [:method, :uri, :body],
    record: record_mode
  }
  config.cassette_library_dir = "spec/support/http_cache/server"
  config.hook_into :webmock

  # Only want VCR to intercept requests to external URLs.
  config.ignore_localhost = true
  
  config.allow_http_connections_when_no_cassette = false
  
  # Temporarily enable config.debug_logger when debugging VCR:
  config.debug_logger = File.open(Rails.root.join('log', 'vcr.log'), 'w')
end

# 4. Start using VCR. See example use in spec/jobs/headline_scraper_job_spec.rb,
#    spec/features/user_upgrades_spec.rb.
#
#    Cassettes will be stored as .yml files in cassette_library_dir 
#    specified above.

# Suggested docs
# --------------
# https://relishapp.com/vcr/vcr/docs
# http://www.rubydoc.info/gems/vcr/frames
