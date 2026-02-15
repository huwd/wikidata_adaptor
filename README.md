# WikidataAdaptor

[![Quality Checks](https://github.com/huwd/wikidata_adaptor/actions/workflows/quality-checks.yml/badge.svg)](https://github.com/huwd/wikidata_adaptor/actions/workflows/quality-checks.yml)
[![Documentation](https://github.com/huwd/wikidata_adaptor/actions/workflows/docs.yml/badge.svg)](https://github.com/huwd/wikidata_adaptor/actions/workflows/docs.yml)

A Ruby gem providing a clean, well-documented interface to the [Wikibase REST API](https://doc.wikimedia.org/Wikibase/master/js/rest-api/). Interact with Wikidata and other Wikibase instances to read and write structured data.

## Features

- **100% API coverage** - All 65 endpoints from Wikibase REST API v1.4
- **Fully documented** - 100% YARD documentation coverage
- **Well-tested** - Comprehensive unit and integration test suites
- **Structured JSON responses** - Consistent response shapes from the API
- **Test helpers included** - WebMock stubs for easy testing in your applications

Supported operations:
- **Items & Properties** - Create, read, update (GET, POST, PATCH)
- **Labels** - Multi-language labels with fallback support (GET, PUT, PATCH, DELETE)
- **Descriptions** - Multi-language descriptions (GET, PUT, PATCH, DELETE)
- **Aliases** - Alternative names in multiple languages (GET, POST, PATCH)
- **Statements** - Claims and references (GET, POST, PUT, PATCH, DELETE)
- **Sitelinks** - Links to related wiki pages (GET, PUT, PATCH, DELETE)
- **Search** - Full-text search and autocomplete suggestions

## Installation

Add this line to your application's Gemfile:

```ruby
gem "wikidata_adaptor"
```

Then execute:

```bash
bundle install
```

Or install directly:

```bash
gem install wikidata_adaptor
```

## Quick Start

```ruby
require "wikidata_adaptor"

# Create a client
client = WikidataAdaptor.rest_api

# Get an item (Douglas Adams - Q42)
item = client.get_item("Q42")
puts item["labels"]["en"]  # => "Douglas Adams"

# Get labels in a specific language
labels = client.get_item_labels("Q42")
puts labels["en"]  # => "Douglas Adams"
puts labels["fr"]  # => "Douglas Adams"

# Search for items
results = client.search_items("Douglas Adams")
results.each do |result|
  puts "#{result['id']}: #{result['label']}"
end
```

## Documentation

- **[API Documentation](https://huwd.github.io/wikidata_adaptor/)** - Full YARD documentation
- **[Wikibase REST API Reference](https://doc.wikimedia.org/Wikibase/master/js/rest-api/)** - Official API docs
- **[CHANGELOG](CHANGELOG.md)** - Version history and changes

## Usage

### Reading Data

```ruby
# Get an item with all its data
item = client.get_item("Q42")

# Get specific language label
label = client.get_item_label("Q42", "en")

# Get label with language fallback
label = client.get_item_label_with_language_fallback("Q42", "en-gb")

# Get descriptions
desc = client.get_item_description("Q42", "en")

# Get aliases
aliases = client.get_item_aliases("Q42")

# Get statements (claims)
statements = client.get_item_statements("Q42")

# Filter statements by property
statements = client.get_item_statements("Q42", property: "P31")  # instance of
```

### Search

```ruby
# Full-text search
results = client.search_items("Albert Einstein")

# Autocomplete suggestions
suggestions = client.suggest_items("Einst")

# Search properties
properties = client.search_properties("instance of")
```

### Writing Data (requires authentication)

```ruby
# Configure an authenticated REST API client with a bearer token
rest_api = WikidataAdaptor::RestApi.new(
  "https://www.wikidata.org/w/rest.php/wikibase",
  bearer_token: "your_oauth_token"
)

# Build a WikidataAdaptor client using the authenticated REST API instance
client = WikidataAdaptor::Client.new(rest_api: rest_api)
# Create a new item
new_item = client.post_item({
  item: {
    labels: { en: "My New Item" },
    descriptions: { en: "A test item" }
  },
  comment: "Creating test item"
})

# Update a label
client.put_item_label("Q42", "en", {
  label: "Douglas Noël Adams",
  comment: "Adding middle name"
})

# Add a statement
client.post_item_statement("Q42", {
  statement: {
    property: { id: "P31" },
    value: { content: "Q5", type: "item" }
  },
  comment: "Adding instance of human"
})

# Delete a label
client.delete_item_label("Q42", "en", {
  comment: "Removing English label"
})
```

### Using Different Wikibase Instances

By default, the gem connects to Wikidata. To use a different Wikibase instance:

```ruby
ENV["WIKIBASE_REST_ENDPOINT"] = "https://your-wikibase.org/w/rest.php/wikibase"
client = WikidataAdaptor.rest_api
```

### Test Helpers

The gem includes WebMock test helpers for easy testing:

```ruby
require "wikidata_adaptor/test_helpers/rest_api"

RSpec.describe MyClass do
  include WikidataAdaptor::TestHelpers::RestApi

  it "fetches an item" do
    stub_get_item("Q42")  # Stubs the API call

    result = MyClass.fetch_item("Q42")
    expect(result["labels"]["en"]).to eq("Douglas Adams")
  end
end
```

See the [test helpers documentation](https://huwd.github.io/wikidata_adaptor/WikidataAdaptor/TestHelpers/RestApi.html) for all available stubs.

## Development

After checking out the repository:

```bash
# Install dependencies
bundle install

# Run tests
bundle exec rake           # Run all tests + RuboCop
bundle exec rspec          # Run unit tests only
bundle exec rubocop        # Run linter only

# Generate documentation
bundle exec rake yard

# Run integration tests (requires Docker)
./script/integration-up    # Start Wikibase instance
./script/integration-test  # Run integration tests
./script/integration-down  # Stop Wikibase instance
```

### Project Structure

```
lib/
├── wikidata_adaptor/
│   ├── rest_api.rb              # Main client class
│   ├── rest_api/                # API endpoint modules
│   │   ├── items.rb
│   │   ├── labels.rb
│   │   ├── statements.rb
│   │   └── ...
│   └── test_helpers/            # WebMock test stubs
│       └── rest_api/
│           ├── items.rb
│           ├── labels.rb
│           └── ...
spec/
├── wikidata_adaptor/rest_api/  # Unit tests
└── integration/                 # Integration tests
```

## Requirements

- Ruby >= 3.2.0
- Bundler

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/huwd/wikidata_adaptor).

1. Fork the repository
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Make your changes with tests
4. Ensure all tests pass (`bundle exec rake`)
5. Commit following [commit conventions](CLAUDE.md#commit-standards)
6. Push to the branch (`git push origin my-new-feature`)
7. Create a Pull Request

Please read our [Code of Conduct](CODE_OF_CONDUCT.md) before contributing.

See [CLAUDE.md](CLAUDE.md) for detailed development guidelines including:
- Commit standards (Conventional Commits)
- Git workflow (branch/PR process)
- TDD workflow
- Testing conventions

## License

This gem is available as open source under the terms of the [MIT License](LICENSE.txt).

## Code of Conduct

Everyone interacting in the WikidataAdaptor project is expected to follow the [Code of Conduct](CODE_OF_CONDUCT.md).

## Links

- [Documentation](https://huwd.github.io/wikidata_adaptor/)
- [Source Code](https://github.com/huwd/wikidata_adaptor)
- [Issue Tracker](https://github.com/huwd/wikidata_adaptor/issues)
- [Changelog](CHANGELOG.md)
- [Wikibase REST API](https://doc.wikimedia.org/Wikibase/master/js/rest-api/)
- [Wikidata](https://www.wikidata.org/)
