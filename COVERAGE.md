# API Coverage

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
