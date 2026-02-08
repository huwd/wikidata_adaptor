# frozen_string_literal: true

require "wikidata_adaptor"
require "webmock/rspec"
require "uri"

if ENV["INTEGRATION"] == "1"
  # Allow connections to localhost and the host specified in WIKIBASE_REST_ENDPOINT
  allowed_hosts = ["localhost", "127.0.0.1"]
  if ENV["WIKIBASE_REST_ENDPOINT"]
    begin
      uri = URI.parse(ENV["WIKIBASE_REST_ENDPOINT"])
      allowed_hosts << uri.host if uri.host
    rescue URI::InvalidURIError
      # If the URL is invalid, just allow localhost
      warn "Warning: WIKIBASE_REST_ENDPOINT is not a valid URI: #{ENV["WIKIBASE_REST_ENDPOINT"]}"
    end
  end
  WebMock.disable_net_connect!(allow: allowed_hosts.uniq)
else
  WebMock.disable_net_connect!
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Exclude integration tests by default unless INTEGRATION=1 is set
  config.filter_run_excluding integration: true unless ENV["INTEGRATION"] == "1"
end
