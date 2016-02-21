require 'webmock/rspec'

# 2. Copy spec/support/http_record.rb into your project:
require_relative 'http_record'

WebMock.disable_net_connect!(allow_localhost: true) if HttpRecord.off?
