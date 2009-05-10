# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{to_hash}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jakub Kuźma"]
  s.date = %q{2009-05-10}
  s.description = %q{Use to_hash(...) together with default to_json/to_xml/to_yaml methods to get quick and powerful object serialization.}
  s.email = %q{qoobaa@gmail.com}
  s.files = ["README.rdoc", "VERSION.yml", "lib/to_hash.rb", "test/to_hash_test.rb"]
  s.homepage = %q{http://github.com/qoobaa/to_hash}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{ToHash module for easy object serialization to JSON, XML, YAML, etc.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
