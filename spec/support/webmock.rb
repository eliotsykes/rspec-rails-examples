require 'webmock/rspec'

# To enable recording new responses temporarily, run the individual spec
# and prepend with RECORD set to true:
# RECORD=true bin/rspec spec/features/user_upgrades_spec.rb
prevent_recording = ('true' != ENV['RECORD'])

WebMock.disable_net_connect!(allow_localhost: true) if prevent_recording
