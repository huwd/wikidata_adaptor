## [1.0.0] - 2025-02-15

### Added

- **YARD Documentation** - Complete API documentation with 100% coverage
  (193/193 methods documented)
- YARD gem (~> 0.9) for HTML documentation generation with Markdown support
- redcarpet gem (~> 3.6) for Markdown rendering in YARD docs
- rubocop-yard gem for YARD documentation linting and enforcement
- `.yardopts` configuration file for consistent documentation generation
- Rake task for YARD documentation: `bundle exec rake yard`
- GitHub Actions workflow for automated YARD documentation deployment to
  GitHub Pages
- YARD documentation build check in pre-merge quality checks workflow
- Comprehensive README.md with installation, usage examples, and API coverage
- GitHub Actions badges for quality checks and documentation status
- DELETE label endpoints (`delete_item_label`, `delete_property_label`)
  to remove labels by language
- DELETE description endpoints (`delete_item_description`,
  `delete_property_description`) to remove descriptions by language
- DELETE sitelink endpoint (`delete_item_sitelink`) to remove sitelinks
- DELETE statement endpoints (`delete_item_statement`,
  `delete_property_statement`, `delete_statement`) to remove statements
- Dependabot configuration with aggressive grouping for low-maintenance
  dependency updates
- Automated RubyGems publishing workflow with OIDC trusted publishing
- Release process documentation in CLAUDE.md with step-by-step guide
- POST item endpoint (`post_item`) with test helpers for error scenarios
  (invalid item, access denied, data policy violation, request limit)
- POST property endpoint (`post_property`) with matching error stubs
- POST aliases endpoints (`post_item_aliases`, `post_property_aliases`)
  to append aliases in a given language
- POST statement endpoints (`post_item_statement`,
  `post_property_statement`) to create statements on entities
- PUT label endpoints (`put_item_label`, `put_property_label`)
  to replace a single label by language
- PUT description endpoints (`put_item_description`,
  `put_property_description`) to replace a single description by language
- PUT sitelink endpoint (`put_item_sitelink`) to replace a sitelink
  by site ID
- PUT statement endpoints (`put_item_statement`,
  `put_property_statement`, `put_statement`) to replace statements
- PATCH item and property endpoints (`patch_item`, `patch_property`)
  for JSON Patch updates to entire entities
- PATCH label endpoints (`patch_item_labels`, `patch_property_labels`)
  for JSON Patch updates to labels
- PATCH description endpoints (`patch_item_descriptions`,
  `patch_property_descriptions`) for JSON Patch updates to descriptions
- PATCH alias endpoints (`patch_item_aliases`, `patch_property_aliases`)
  for JSON Patch updates to aliases
- PATCH sitelinks endpoint (`patch_item_sitelinks`) for JSON Patch
  updates to sitelinks
- PATCH statement endpoints (`patch_item_statement`,
  `patch_property_statement`, `patch_statement`) for JSON Patch updates
  to statements
- Search items (`search_items`, `suggest_items`) and search properties
  (`search_properties`) endpoints
- Language fallback handling for labels via 307 redirect following
- Integration test suite with Docker Compose (Wikibase stack), helper
  scripts (`integration-up`, `integration-test`, `integration-down`),
  and RSpec filter to exclude integration tests by default
- Test helpers using OpenAPI spec v1.4 examples for response fixtures
- Bundled copy of OpenAPI Spec v1.4 for test comparisons
- `CLAUDE.md` project guidance with Git standards, commit conventions,
  TDD workflow, and release process
- `rubocop-rake` and `rubocop-rspec` plugins
- Gemspec metadata: documentation_uri and bug_tracker_uri for RubyGems.org

### Changed

- **Documentation** - README completely rewritten with comprehensive usage
  examples, quick start guide, and links to all relevant documentation
- YARD documentation now includes README.md and CLAUDE.md in generated docs
- Dependabot configured to group minor/patch updates and run weekly
  (7-day cooldown)

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

- YARD syntax errors: `Array[String]` → `Array<String>` in aliases.rb
- RuboCop offenses: `RSpec/BeNil`, `RSpec/EmptyLineAfterExample`,
  `RSpec/SpecFilePathFormat` (missing `_spec` suffix on
  `property_data_types`)
- Gemspec: removed commented `allowed_push_host` placeholder

### Infrastructure

- **CI/CD**: GitHub Pages deployment for documentation
- **CI/CD**: YARD docs build check in quality-checks workflow
- **CI/CD**: Automated RubyGems publishing with comprehensive validation
- **Dependencies**: Dependabot with aggressive grouping (bundler + actions)
- **Documentation**: 100% YARD coverage with rubocop-yard linting
- **Release**: Dry-run mode for testing releases without publishing

## [0.0.0] - 2023-06-01

- Initial bootstrapping
