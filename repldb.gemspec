Gem::Specification.new do |s|
  s.name = "repldb"
  s.version            = "0.0.1"
  s.default_executable = "repldb"

  s.licenses = "MIT"
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Coder100"]
  s.date = %q{2021-03-26}
  s.description = %q{A simple client for replit db}
  s.files = ["README.md", "LICENSE", "lib/repldb.rb", "bin/repldb"]
  s.test_files = ["test/test.rb"]
  s.homepage = %q{https://github.com/cursorweb/rubygem-repldb}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Ruby Repldb!}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
