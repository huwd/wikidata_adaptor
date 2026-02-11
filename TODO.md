# API Coverage TODO

Tracking coverage of Wikibase REST API v1.4 (OpenAPI spec).

**Covered: 30 / 65 endpoints (46%)**

## Covered endpoints

All GET endpoints plus `POST /v1/entities/items` are implemented.

| # | Method | Path | Ruby method | Module |
|---|--------|------|-------------|--------|
| 1 | GET | `/v0/search/items` | `search_items` | SearchItem |
| 2 | GET | `/v0/search/properties` | `search_properties` | SearchProperty |
| 3 | GET | `/v0/suggest/items` | `suggest_items` | SearchItem |
| 4 | GET | `/v0/suggest/properties` | `suggest_properties` | SearchProperty |
| 5 | GET | `/v1/entities/items/{item_id}` | `get_item` | Items |
| 6 | GET | `/v1/entities/items/{item_id}/aliases` | `get_item_aliases` | Aliases |
| 7 | GET | `/v1/entities/items/{item_id}/aliases/{language_code}` | `get_item_alias` | Aliases |
| 8 | GET | `/v1/entities/items/{item_id}/descriptions` | `get_item_descriptions` | Descriptions |
| 9 | GET | `/v1/entities/items/{item_id}/descriptions/{language_code}` | `get_item_description` | Descriptions |
| 10 | GET | `/v1/entities/items/{item_id}/labels` | `get_item_labels` | Labels |
| 11 | GET | `/v1/entities/items/{item_id}/labels/{language_code}` | `get_item_label` | Labels |
| 12 | GET | `/v1/entities/items/{item_id}/labels_with_language_fallback/{language_code}` | `get_item_label_with_language_fallback` | Labels |
| 13 | GET | `/v1/entities/items/{item_id}/sitelinks` | `get_item_sitelinks` | Sitelinks |
| 14 | GET | `/v1/entities/items/{item_id}/sitelinks/{site_id}` | `get_item_sitelink` | Sitelinks |
| 15 | GET | `/v1/entities/items/{item_id}/statements` | `get_item_statements` | Statements |
| 16 | GET | `/v1/entities/items/{item_id}/statements/{statement_id}` | `get_item_statement` | Statements |
| 17 | GET | `/v1/entities/properties/{property_id}` | `get_property` | Properties |
| 18 | GET | `/v1/entities/properties/{property_id}/aliases` | `get_property_aliases` | Aliases |
| 19 | GET | `/v1/entities/properties/{property_id}/aliases/{language_code}` | `get_property_alias` | Aliases |
| 20 | GET | `/v1/entities/properties/{property_id}/descriptions` | `get_property_descriptions` | Descriptions |
| 21 | GET | `/v1/entities/properties/{property_id}/descriptions/{language_code}` | `get_property_description` | Descriptions |
| 22 | GET | `/v1/entities/properties/{property_id}/labels` | `get_property_labels` | Labels |
| 23 | GET | `/v1/entities/properties/{property_id}/labels/{language_code}` | `get_property_label` | Labels |
| 24 | GET | `/v1/entities/properties/{property_id}/labels_with_language_fallback/{language_code}` | `get_property_label_with_language_fallback` | Labels |
| 25 | GET | `/v1/entities/properties/{property_id}/statements` | `get_property_statements` | Statements |
| 26 | GET | `/v1/entities/properties/{property_id}/statements/{statement_id}` | `get_property_statement` | Statements |
| 27 | GET | `/v1/openapi.json` | `get_openapi_document` | OpenApiDocument |
| 28 | GET | `/v1/property-data-types` | `get_property_data_types` | PropertyDataTypes |
| 29 | GET | `/v1/statements/{statement_id}` | `get_statement` | Statements |
| 30 | POST | `/v1/entities/items` | `post_item` | Items |

## Uncovered endpoints (35)

### GET (2) — language fallback for descriptions

| Path | Target module |
|------|---------------|
| `/v1/entities/items/{item_id}/descriptions_with_language_fallback/{language_code}` | Descriptions |
| `/v1/entities/properties/{property_id}/descriptions_with_language_fallback/{language_code}` | Descriptions |

### POST (5) — create sub-resources and properties

| Path | Target module |
|------|---------------|
| `/v1/entities/items/{item_id}/aliases/{language_code}` | Aliases |
| `/v1/entities/items/{item_id}/statements` | Statements |
| `/v1/entities/properties` | Properties |
| `/v1/entities/properties/{property_id}/aliases/{language_code}` | Aliases |
| `/v1/entities/properties/{property_id}/statements` | Statements |

### PATCH (12) — partial updates

| Path | Target module |
|------|---------------|
| `/v1/entities/items/{item_id}` | Items |
| `/v1/entities/items/{item_id}/aliases` | Aliases |
| `/v1/entities/items/{item_id}/descriptions` | Descriptions |
| `/v1/entities/items/{item_id}/labels` | Labels |
| `/v1/entities/items/{item_id}/sitelinks` | Sitelinks |
| `/v1/entities/items/{item_id}/statements/{statement_id}` | Statements |
| `/v1/entities/properties/{property_id}` | Properties |
| `/v1/entities/properties/{property_id}/aliases` | Aliases |
| `/v1/entities/properties/{property_id}/descriptions` | Descriptions |
| `/v1/entities/properties/{property_id}/labels` | Labels |
| `/v1/entities/properties/{property_id}/statements/{statement_id}` | Statements |
| `/v1/statements/{statement_id}` | Statements |

### PUT (8) — full replacements

| Path | Target module |
|------|---------------|
| `/v1/entities/items/{item_id}/descriptions/{language_code}` | Descriptions |
| `/v1/entities/items/{item_id}/labels/{language_code}` | Labels |
| `/v1/entities/items/{item_id}/sitelinks/{site_id}` | Sitelinks |
| `/v1/entities/items/{item_id}/statements/{statement_id}` | Statements |
| `/v1/entities/properties/{property_id}/descriptions/{language_code}` | Descriptions |
| `/v1/entities/properties/{property_id}/labels/{language_code}` | Labels |
| `/v1/entities/properties/{property_id}/statements/{statement_id}` | Statements |
| `/v1/statements/{statement_id}` | Statements |

### DELETE (8) — removals

| Path | Target module |
|------|---------------|
| `/v1/entities/items/{item_id}/descriptions/{language_code}` | Descriptions |
| `/v1/entities/items/{item_id}/labels/{language_code}` | Labels |
| `/v1/entities/items/{item_id}/sitelinks/{site_id}` | Sitelinks |
| `/v1/entities/items/{item_id}/statements/{statement_id}` | Statements |
| `/v1/entities/properties/{property_id}/descriptions/{language_code}` | Descriptions |
| `/v1/entities/properties/{property_id}/labels/{language_code}` | Labels |
| `/v1/entities/properties/{property_id}/statements/{statement_id}` | Statements |
| `/v1/statements/{statement_id}` | Statements |

## Implementation plan

Work is grouped into phases. Each phase adds one HTTP method across all
resource modules, keeping each commit atomic and reviewable. Within each
phase, implement item endpoints first, then properties, then top-level
statements — mirroring the existing pattern.

For each endpoint, the work is:
1. Add the method to the relevant `lib/wikidata_adaptor/rest_api/<module>.rb`
2. Add the corresponding `stub_*` helper to `lib/wikidata_adaptor/test_helpers/rest_api/<module>.rb`
3. Add unit tests in `spec/wikidata_adaptor/rest_api/<module>_spec.rb`
4. Add integration tests in `spec/integration/<module>_spec.rb` (where applicable)

### Phase 1 — GET: description language fallback (2 endpoints)

Small change, extends the existing pattern in Labels to Descriptions.

- `get_item_description_with_language_fallback` in Descriptions
- `get_property_description_with_language_fallback` in Descriptions

### Phase 2 — POST: create sub-resources (5 endpoints)

Follows the pattern established by `post_item`. All require
`WIKIBASE_BEARER_TOKEN` for authentication.

- `post_item_aliases` in Aliases
- `post_item_statement` in Statements
- `post_property` in Properties
- `post_property_aliases` in Aliases
- `post_property_statement` in Statements

### Phase 3 — PUT: replace resources (8 endpoints)

Sets a single resource to a new value. Requires auth.

- Labels: `put_item_label`, `put_property_label`
- Descriptions: `put_item_description`, `put_property_description`
- Sitelinks: `put_item_sitelink`
- Statements: `put_item_statement`, `put_property_statement`, `put_statement`

### Phase 4 — PATCH: partial updates (12 endpoints)

Applies JSON Patch operations. Requires auth. Largest batch — consider
splitting into sub-PRs per module.

- Items: `patch_item`
- Labels: `patch_item_labels`, `patch_property_labels`
- Descriptions: `patch_item_descriptions`, `patch_property_descriptions`
- Aliases: `patch_item_aliases`, `patch_property_aliases`
- Sitelinks: `patch_item_sitelinks`
- Statements: `patch_item_statement`, `patch_property_statement`, `patch_statement`
- Properties: `patch_property`

### Phase 5 — DELETE: remove resources (8 endpoints)

Requires auth. Returns 200 with `"Deleted"` response.

- Labels: `delete_item_label`, `delete_property_label`
- Descriptions: `delete_item_description`, `delete_property_description`
- Sitelinks: `delete_item_sitelink`
- Statements: `delete_item_statement`, `delete_property_statement`, `delete_statement`
