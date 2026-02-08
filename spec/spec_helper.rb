# frozen_string_literal: true

require "wikidata_adaptor"
require "webmock/rspec"

if ENV["INTEGRATION"] == "1"
  # Allow connections to localhost and the configured Wikibase endpoint
  allowed_hosts = ["localhost"]
  if ENV["WIKIBASE_REST_ENDPOINT"]
    endpoint_uri = URI.parse(ENV["WIKIBASE_REST_ENDPOINT"])
    allowed_hosts << endpoint_uri.host if endpoint_uri.host
  end
  WebMock.disable_net_connect!(allow: allowed_hosts)
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

  # Exclude integration specs by default unless INTEGRATION=1
  config.filter_run_excluding integration: true unless ENV["INTEGRATION"] == "1"
end
