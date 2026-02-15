# frozen_string_literal: true

module WikidataAdaptor
  module TestHelpers
    module RestApi
      # WebMock stubs for Wikibase REST API support utilities
      module Support
        # Load the OpenAPI specification from file
        #
        # @return [Hash] The parsed OpenAPI specification
        def load_openapi_spec
          JSON.parse(
            File.read(File.join("spec", "openapi", "openapi.json"))
          )
        end

        # Load example response from OpenAPI specification for a given path and method
        #
        # @param path [String] The API path
        # @param method [String] The HTTP method
        # @param response_code [String] The HTTP response code
        #
        # @return [Hash] The example response
        def load_path_example(path, method, response_code = "200")
          load_openapi_spec.dig(
            "paths",
            path,
            method,
            "responses",
            response_code,
            "content",
            "application/json",
            "example"
          )
        end

        # Fixture for a posted item response
        #
        # @return [Hash] The posted item response fixture
        def posted_item_response_fixture
          {
            "id" => "Q24",
            "type" => "item",
            "labels" => {
              "en" => "Jane Doe",
              "ru" => "Джейн Доу"
            },
            "descriptions" => {
              "en" => "famous person",
              "ru" => "известная личность"
            },
            "aliases" => {
              "en" => [
                "Jane M. Doe",
                "JD"
              ],
              "ru" => [
                "Джейн М. Доу"
              ]
            },
            "statements" => {
              "P694" => [
                {
                  "id" => "Q24$BB728546-A400-4116-A772-16D54B62AC2B",
                  "rank" => "normal",
                  "property" => {
                    "id" => "P694",
                    "data_type" => "wikibase-item"
                  },
                  "value" => {
                    "type" => "value",
                    "content" => "Q626683"
                  },
                  "qualifiers" => [],
                  "references" => []
                }
              ],
              "P476" => [
                {
                  "id" => "Q24$F3B2F956-B6AB-4984-8D89-BEE0FFFA3385",
                  "rank" => "normal",
                  "property" => {
                    "id" => "P476",
                    "data_type" => "time"
                  },
                  "value" => {
                    "type" => "value",
                    "content" => {
                      "time" => "+1986-01-27T00:00:00Z",
                      "precision" => 11,
                      "calendarmodel" => "http://www.wikidata.org/entity/Q1985727"
                    }
                  },
                  "qualifiers" => [],
                  "references" => []
                }
              ],
              "P17" => [
                {
                  "id" => "Q24$9966A1CA-F3F5-4B1D-A534-7CD5953169DA",
                  "rank" => "normal",
                  "property" => {
                    "id" => "P17",
                    "data_type" => "string"
                  },
                  "value" => {
                    "type" => "value",
                    "content" => "Senior Team Supervisor"
                  },
                  "qualifiers" => [
                    {
                      "property" => {
                        "id" => "P706",
                        "data_type" => "time"
                      },
                      "value" => {
                        "type" => "value",
                        "content" => {
                          "time" => "+2023-06-13T00:00:00Z",
                          "precision" => 11,
                          "calendarmodel" => "http://www.wikidata.org/entity/Q1985727"
                        }
                      }
                    }
                  ],
                  "references" => [
                    {
                      "hash" => "7ccd777f870b71a4c5056c7fd2a83a22cc39be6d",
                      "parts" => [
                        {
                          "property" => {
                            "id" => "P709",
                            "data_type" => "url"
                          },
                          "value" => {
                            "type" => "value",
                            "content" => "https://news.example.org"
                          }
                        }
                      ]
                    }
                  ]
                }
              ]
            },
            "sitelinks" => {
              "enwiki" => {
                "title" => "Jane Doe",
                "badges" => [],
                "url" => "https://enwiki.example.org/wiki/Jane_Doe"
              },
              "ruwiki" => {
                "title" => "Джейн Доу",
                "badges" => [],
                "url" => "https://ruwiki.example.org/wiki/Джейн_Доу"
              }
            }
          }
        end

        # Fixture for a posted property response
        #
        # @return [Hash] The posted property response fixture
        def posted_property_response_fixture
          {
            "id" => "P1",
            "type" => "property",
            "data_type" => "string",
            "labels" => {
              "en" => "instance of"
            },
            "descriptions" => {
              "en" => "that class of which this subject is a particular example and member"
            },
            "aliases" => {
              "en" => ["is a"]
            },
            "statements" => {}
          }
        end

        # Fixture for a property creation payload
        #
        # @return [Hash] The posted property payload fixture
        def posted_property_payload_fixture
          {
            "property" => {
              "data_type" => "string",
              "labels" => {
                "en" => "instance of"
              },
              "descriptions" => {
                "en" => "that class of which this subject is a particular example and member"
              },
              "aliases" => {
                "en" => ["is a"]
              }
            },
            "comment" => "Create a Property"
          }
        end

        # Fixture for an item creation payload
        #
        # @return [Hash] The posted item payload fixture
        def posted_item_payload_fixture
          {
            "item" => {
              "labels" => {
                "en" => "Jane Doe",
                "ru" => "Джейн Доу"
              },
              "descriptions" => {
                "en" => "famous person",
                "ru" => "известная личность"
              },
              "aliases" => {
                "en" => [
                  "Jane M. Doe",
                  "JD"
                ],
                "ru" => [
                  "Джейн М. Доу"
                ]
              },
              "statements" => {
                "P694" => [
                  {
                    "property" => {
                      "id" => "P694"
                    },
                    "value" => {
                      "type" => "value",
                      "content" => "Q626683"
                    }
                  }
                ],
                "P476" => [
                  {
                    "property" => {
                      "id" => "P476"
                    },
                    "value" => {
                      "type" => "value",
                      "content" => {
                        "time" => "+1986-01-27T00:00:00Z",
                        "precision" => 11,
                        "calendarmodel" => "http://www.wikidata.org/entity/Q1985727"
                      }
                    }
                  }
                ],
                "P17" => [
                  {
                    "property" => {
                      "id" => "P17"
                    },
                    "value" => {
                      "type" => "value",
                      "content" => "Senior Team Supervisor"
                    },
                    "qualifiers" => [
                      {
                        "property" => {
                          "id" => "P706"
                        },
                        "value" => {
                          "type" => "value",
                          "content" => {
                            "time" => "+2023-06-13T00:00:00Z",
                            "precision" => 11,
                            "calendarmodel" => "http://www.wikidata.org/entity/Q1985727"
                          }
                        }
                      }
                    ],
                    "references" => [
                      {
                        "parts" => [
                          {
                            "property" => {
                              "id" => "P709"
                            },
                            "value" => {
                              "type" => "value",
                              "content" => "https://news.example.org"
                            }
                          }
                        ]
                      }
                    ]
                  }
                ]
              },
              "sitelinks" => {
                "enwiki" => {
                  "title" => "Jane Doe"
                },
                "ruwiki" => {
                  "title" => "Джейн Доу"
                }
              }
            },
            "comment" => "Create an Item for Jane Doe"
          }
        end
      end
    end
  end
end
