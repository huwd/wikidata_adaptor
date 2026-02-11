## [Unreleased]

### Added

- POST item endpoint (`post_item`) with test helpers for error scenarios
  (invalid item, access denied, data policy violation, request limit)
- Search items (`search_items`, `suggest_items`) and search properties
  (`search_properties`) endpoints
- Language fallback handling for labels via 307 redirect following
- Integration test suite with Docker Compose (Wikibase stack), helper
  scripts (`integration-up`, `integration-test`, `integration-down`),
  and RSpec filter to exclude integration tests by default
- Test helpers using OpenAPI spec v1.4 examples for response fixtures
- Bundled copy of OpenAPI Spec v1.4 for test comparisons
- `CLAUDE.md` project guidance
- `rubocop-rake` and `rubocop-rspec` plugins

### Changed

- Refactored `RestApi` into separate modules per resource: Items, Labels,
  Descriptions, Aliases, Statements, Sitelinks, Properties, PropertyDataTypes,
  OpenApiDocument, SearchItem, SearchProperty
- Moved spec paths to mirror source layout
  (`spec/wikidata_adaptor/rest_api/`)
- Updated API paths to target v1 endpoints
- Updated `api_adaptor` dependency to v0.1.0
- Updated `stub_rest_api_request` to accept headers
- Updated target Ruby version to >= 3.2

### Fixed

- RuboCop offenses: `RSpec/BeNil`, `RSpec/EmptyLineAfterExample`,
  `RSpec/SpecFilePathFormat` (missing `_spec` suffix on
  `property_data_types`)

## [0.0.0] - 2023-06-01

- Initial bootstrapping
