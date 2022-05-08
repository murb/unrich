# frozen_string_literal: true

require_relative "lib/unrich/version"

Gem::Specification.new do |spec|
  spec.name          = "unrich"
  spec.version       = Unrich::VERSION
  spec.authors       = ["murb"]
  spec.email         = ["git@murb.nl"]

  spec.summary       = "unrich unriches RTF; (rtf2txt)"
  spec.description   = "unrich is a pure ruby rtf2txt converter; it reads an rtf and can only output it as UTF-8 encoded string"
  spec.homepage      = "https://github.com/murb/unrich"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/murb/unrich"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
