# frozen_string_literal: true

require_relative "lib/wikidata_adaptor/version"

Gem::Specification.new do |spec|
  spec.name = "wikidata_adaptor"
  spec.version = WikidataAdaptor::VERSION
  spec.authors = ["Huw Diprose"]
  spec.email = ["mail@huwdiprose.co.uk"]

  spec.summary = "An API wrapper to interact with Wikidata and Wikibase APIs"
  spec.description = "Use the Wikibase Action and REST API to interact with wikidata"
  spec.homepage = "https://github.com/huwd/wikidata_adaptor"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/huwd/wikidata_adaptor"
  spec.metadata["changelog_uri"] = "https://github.com/huwd/wikidata_adaptor/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "api_adaptor", "~> 0.0.1"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
