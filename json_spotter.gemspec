# frozen_string_literal: true

require_relative "lib/json_spotter"

Gem::Specification.new do |spec|
  spec.platform = Gem::Platform::RUBY
  spec.name = "json_spotter"
  spec.version = JsonSpotter::VERSION
  spec.authors = ["Anatoly Lapshin"]
  spec.email = ["a.lapshin@3commas.io"]
  spec.license  = "MIT"

  spec.summary = "Ruby gem to extract data from JSON streams"
  spec.description = "json_spotter is a gem to process big json documents in a stream-way. " \
                     "It provides a special json-based language to describe the data that has to " \
                     "be extracted from the json stream of data."
  spec.homepage = "https://github.com/holywarez/json_spotter"
  spec.required_ruby_version = ">= 3.2.1"

  spec.metadata = {
    "bug_tracker_uri"   => "https://github.com/holywarez/json_spotter/issues",
    "documentation_uri" => "https://github.com/holywarez/json_spotter/blob/main/docs",
    "source_code_uri"   => "https://github.com/holywarez/json_spotter/tree/main",
    "homepage_uri"      => spec.homepage,
  }

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

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
