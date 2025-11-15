# frozen_string_literal: true

module WikidataAdaptor
  module TestHelpers
    module RestApi
      module Support
        def load_openapi_spec
          JSON.parse(
            File.read(File.join("spec", "openapi", "openapi.json"))
          )
        end

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
      end
    end
  end
end
