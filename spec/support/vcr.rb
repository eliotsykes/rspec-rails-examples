# Installing VCR:

# 1. Add vcr and webmock gems to Gemfile:
#
# group :test do
#   gem 'vcr'
#   gem 'webmock'
# end

# 2. Create a file like this one you're reading in spec/support/vcr.rb
VCR.configure do |config|
  config.cassette_library_dir = "spec/support/http_cache/vcr"
  config.hook_into :webmock

  # Only want VCR to intercept requests to external URLs.
  config.ignore_localhost = true
end

# 3. Start using VCR. See example use in spec/jobs/headline_scraper_job_spec.rb.
#    Cassettes will be stored as .yml files in cassette_library_dir specified above.

# Suggested docs
# --------------
# https://relishapp.com/vcr/vcr/docs
# http://www.rubydoc.info/gems/vcr/frames