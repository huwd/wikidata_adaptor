# API Coverage TODO

Tracking coverage of Wikibase REST API v1.4 (OpenAPI spec).

**Covered: 65 / 65 endpoints (100%)**

## Covered endpoints

All endpoints from the Wikibase REST API v1.4 specification are now implemented.

| #   | Method | Path                                                                                        | Ruby method                                       | Module            |
| --- | ------ | ------------------------------------------------------------------------------------------- | ------------------------------------------------- | ----------------- |
| 1   | GET    | `/v0/search/items`                                                                          | `search_items`                                    | SearchItem        |
| 2   | GET    | `/v0/search/properties`                                                                     | `search_properties`                               | SearchProperty    |
| 3   | GET    | `/v0/suggest/items`                                                                         | `suggest_items`                                   | SearchItem        |
| 4   | GET    | `/v0/suggest/properties`                                                                    | `suggest_properties`                              | SearchProperty    |
| 5   | GET    | `/v1/entities/items/{item_id}`                                                              | `get_item`                                        | Items             |
| 6   | GET    | `/v1/entities/items/{item_id}/aliases`                                                      | `get_item_aliases`                                | Aliases           |
| 7   | GET    | `/v1/entities/items/{item_id}/aliases/{language_code}`                                      | `get_item_alias`                                  | Aliases           |
| 8   | GET    | `/v1/entities/items/{item_id}/descriptions`                                                 | `get_item_descriptions`                           | Descriptions      |
| 9   | GET    | `/v1/entities/items/{item_id}/descriptions/{language_code}`                                 | `get_item_description`                            | Descriptions      |
| 10  | GET    | `/v1/entities/items/{item_id}/labels`                                                       | `get_item_labels`                                 | Labels            |
| 11  | GET    | `/v1/entities/items/{item_id}/labels/{language_code}`                                       | `get_item_label`                                  | Labels            |
| 12  | GET    | `/v1/entities/items/{item_id}/labels_with_language_fallback/{language_code}`                | `get_item_label_with_language_fallback`           | Labels            |
| 13  | GET    | `/v1/entities/items/{item_id}/sitelinks`                                                    | `get_item_sitelinks`                              | Sitelinks         |
| 14  | GET    | `/v1/entities/items/{item_id}/sitelinks/{site_id}`                                          | `get_item_sitelink`                               | Sitelinks         |
| 15  | GET    | `/v1/entities/items/{item_id}/statements`                                                   | `get_item_statements`                             | Statements        |
| 16  | GET    | `/v1/entities/items/{item_id}/statements/{statement_id}`                                    | `get_item_statement`                              | Statements        |
| 17  | GET    | `/v1/entities/properties/{property_id}`                                                     | `get_property`                                    | Properties        |
| 18  | GET    | `/v1/entities/properties/{property_id}/aliases`                                             | `get_property_aliases`                            | Aliases           |
| 19  | GET    | `/v1/entities/properties/{property_id}/aliases/{language_code}`                             | `get_property_alias`                              | Aliases           |
| 20  | GET    | `/v1/entities/properties/{property_id}/descriptions`                                        | `get_property_descriptions`                       | Descriptions      |
| 21  | GET    | `/v1/entities/properties/{property_id}/descriptions/{language_code}`                        | `get_property_description`                        | Descriptions      |
| 22  | GET    | `/v1/entities/properties/{property_id}/labels`                                              | `get_property_labels`                             | Labels            |
| 23  | GET    | `/v1/entities/properties/{property_id}/labels/{language_code}`                              | `get_property_label`                              | Labels            |
| 24  | GET    | `/v1/entities/properties/{property_id}/labels_with_language_fallback/{language_code}`       | `get_property_label_with_language_fallback`       | Labels            |
| 25  | GET    | `/v1/entities/properties/{property_id}/statements`                                          | `get_property_statements`                         | Statements        |
| 26  | GET    | `/v1/entities/properties/{property_id}/statements/{statement_id}`                           | `get_property_statement`                          | Statements        |
| 27  | GET    | `/v1/openapi.json`                                                                          | `get_openapi_document`                            | OpenApiDocument   |
| 28  | GET    | `/v1/property-data-types`                                                                   | `get_property_data_types`                         | PropertyDataTypes |
| 29  | GET    | `/v1/statements/{statement_id}`                                                             | `get_statement`                                   | Statements        |
| 30  | POST   | `/v1/entities/items`                                                                        | `post_item`                                       | Items             |
| 31  | GET    | `/v1/entities/items/{item_id}/descriptions_with_language_fallback/{language_code}`          | `get_item_description_with_language_fallback`     | Descriptions      |
| 32  | GET    | `/v1/entities/properties/{property_id}/descriptions_with_language_fallback/{language_code}` | `get_property_description_with_language_fallback` | Descriptions      |
| 33  | POST   | `/v1/entities/items/{item_id}/aliases/{language_code}`                                      | `post_item_aliases`                               | Aliases           |
| 34  | POST   | `/v1/entities/items/{item_id}/statements`                                                   | `post_item_statement`                             | Statements        |
| 35  | POST   | `/v1/entities/properties`                                                                   | `post_property`                                   | Properties        |
| 36  | POST   | `/v1/entities/properties/{property_id}/aliases/{language_code}`                             | `post_property_aliases`                           | Aliases           |
| 37  | POST   | `/v1/entities/properties/{property_id}/statements`                                          | `post_property_statement`                         | Statements        |
| 38  | PUT    | `/v1/entities/items/{item_id}/labels/{language_code}`                                       | `put_item_label`                                  | Labels            |
| 39  | PUT    | `/v1/entities/properties/{property_id}/labels/{language_code}`                              | `put_property_label`                              | Labels            |
| 40  | PUT    | `/v1/entities/items/{item_id}/descriptions/{language_code}`                                 | `put_item_description`                            | Descriptions      |
| 41  | PUT    | `/v1/entities/properties/{property_id}/descriptions/{language_code}`                        | `put_property_description`                        | Descriptions      |
| 42  | PUT    | `/v1/entities/items/{item_id}/sitelinks/{site_id}`                                          | `put_item_sitelink`                               | Sitelinks         |
| 43  | PUT    | `/v1/entities/items/{item_id}/statements/{statement_id}`                                    | `put_item_statement`                              | Statements        |
| 44  | PUT    | `/v1/entities/properties/{property_id}/statements/{statement_id}`                           | `put_property_statement`                          | Statements        |
| 45  | PUT    | `/v1/statements/{statement_id}`                                                             | `put_statement`                                   | Statements        |
| 46  | PATCH  | `/v1/entities/items/{item_id}`                                                              | `patch_item`                                      | Items             |
| 47  | PATCH  | `/v1/entities/items/{item_id}/aliases`                                                      | `patch_item_aliases`                              | Aliases           |
| 48  | PATCH  | `/v1/entities/items/{item_id}/descriptions`                                                 | `patch_item_descriptions`                         | Descriptions      |
| 49  | PATCH  | `/v1/entities/items/{item_id}/labels`                                                       | `patch_item_labels`                               | Labels            |
| 50  | PATCH  | `/v1/entities/items/{item_id}/sitelinks`                                                    | `patch_item_sitelinks`                            | Sitelinks         |
| 51  | PATCH  | `/v1/entities/items/{item_id}/statements/{statement_id}`                                    | `patch_item_statement`                            | Statements        |
| 52  | PATCH  | `/v1/entities/properties/{property_id}`                                                     | `patch_property`                                  | Properties        |
| 53  | PATCH  | `/v1/entities/properties/{property_id}/aliases`                                             | `patch_property_aliases`                          | Aliases           |
| 54  | PATCH  | `/v1/entities/properties/{property_id}/descriptions`                                        | `patch_property_descriptions`                     | Descriptions      |
| 55  | PATCH  | `/v1/entities/properties/{property_id}/labels`                                              | `patch_property_labels`                           | Labels            |
| 56  | PATCH  | `/v1/entities/properties/{property_id}/statements/{statement_id}`                           | `patch_property_statement`                        | Statements        |
| 57  | PATCH  | `/v1/statements/{statement_id}`                                                             | `patch_statement`                                 | Statements        |
| 58  | DELETE | `/v1/entities/items/{item_id}/labels/{language_code}`                                       | `delete_item_label`                               | Labels            |
| 59  | DELETE | `/v1/entities/properties/{property_id}/labels/{language_code}`                              | `delete_property_label`                           | Labels            |
| 60  | DELETE | `/v1/entities/items/{item_id}/descriptions/{language_code}`                                 | `delete_item_description`                         | Descriptions      |
| 61  | DELETE | `/v1/entities/properties/{property_id}/descriptions/{language_code}`                        | `delete_property_description`                     | Descriptions      |
| 62  | DELETE | `/v1/entities/items/{item_id}/sitelinks/{site_id}`                                          | `delete_item_sitelink`                            | Sitelinks         |
| 63  | DELETE | `/v1/entities/items/{item_id}/statements/{statement_id}`                                    | `delete_item_statement`                           | Statements        |
| 64  | DELETE | `/v1/entities/properties/{property_id}/statements/{statement_id}`                           | `delete_property_statement`                       | Statements        |
| 65  | DELETE | `/v1/statements/{statement_id}`                                                             | `delete_statement`                                | Statements        |

## Implementation plan

Work is grouped into phases. Each phase adds one HTTP method across all resource modules, keeping each commit atomic and reviewable.
Within each phase, implement item endpoints first, then properties, then top-level statements — mirroring the existing pattern.

For each endpoint, the work is:

1. Add the relevant unit tests to `spec/wikidata_adaptor/rest_api/<module>_spec.rb`, then run RuboCop and RSpec. Confirm RuboCop passes and RSpec fails (tests are red).
2. Add the corresponding `stub_*` helper to `lib/wikidata_adaptor/test_helpers/rest_api/<module>.rb`, then run RuboCop and RSpec again. Confirm RuboCop still passes and that RSpec now fails in a more specific way (the test stubs are found but behaviour is not yet implemented).
3. Add the method to the relevant `lib/wikidata_adaptor/rest_api/<module>.rb`, then run RuboCop and RSpec. Confirm both now pass (green).
4. Add integration tests in `spec/integration/<module>_spec.rb` (where applicable)
5. **Update TODO** — Move endpoints from "Uncovered" to "Covered" in `TODO.md` and update counts.

Finally commit following the standards in CLAUDE.md, keeping each stage atomically committed

### Phase 1 — GET: description language fallback (2 endpoints)

Done

### Phase 2 — POST: create sub-resources (5 endpoints)

Done

### Phase 3 — PUT: replace resources (8 endpoints)

Done

### Phase 4 — PATCH: partial updates (12 endpoints)

Done

### Phase 5 — DELETE: remove resources (8 endpoints)

Done

## YARD Docs

### Generate YARD documentation

Add YARD and have it build API documentation (HTML by default; configure a Markdown formatter/plugin if Markdown output is required).

### Format YARD headers

Explore best practices for YARD headers, and consider bringing in linting tools.
Establish best practices and check all covered docs.
Amend the documentation module by module until the published docs align with best practices.

### Add pre-merge check to validate YARD headers

Add a GitHub Action to validate that the YARD docs build succeeds and that headers meet linting standards pre-merge.

### Serve the docs to a GitHub page held against the repo

Add GitHub Actions to publish the YARD docs to the GitHub page held against the repo.

## Publishing workflow

Create a publishing workflow that allows us to push to RubyGems.
Copy what we have in `api_adaptors`, and this work here:
https://github.com/huwd/api_adaptor/pull/53

## Fix the README.md

Put meaningful documentation down and add a guide to how to use the repo.

## Build a quick example app

Test it in anger against real Wikidata.

## Dependabot on

- Configure Dependabot for aggressive grouping (all dev dependencies in one group unless major).
- Group other dependencies by similar source (unless major).
- Group all GitHub Actions in one.
- Add a 7 day cooldown unless there's a security advisory.

## Release v1.0.0

Go live checklist:

- Ensure the changelog is up to date.
- Verify that docs are published correctly.
- Confirm RubyGems is properly set up, and repo URLs point to the right place.
- Test the release process and verify it works with a dry run.
- Check that README.md is accurate and links to example usage.
- Release v1.0.0 with good change release tags.
