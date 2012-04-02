# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "pry-git"
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Mair (banisterfiend)"]
  s.date = "2012-04-03"
  s.description = "A Ruby-aware git layer"
  s.email = "jrmair@gmail.com"
  s.files = ["lib/pry-git/version.rb", "lib/pry-git.rb", "test/test.rb", "CHANGELOG", "README.md", "Rakefile"]
  s.homepage = "http://github.com/pry/pry-git"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.16"
  s.summary = "A Ruby-aware git layer"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<diffy>, [">= 0"])
      s.add_runtime_dependency(%q<grit>, [">= 0"])
      s.add_runtime_dependency(%q<pry>, [">= 0.9.8"])
    else
      s.add_dependency(%q<diffy>, [">= 0"])
      s.add_dependency(%q<grit>, [">= 0"])
      s.add_dependency(%q<pry>, [">= 0.9.8"])
    end
  else
    s.add_dependency(%q<diffy>, [">= 0"])
    s.add_dependency(%q<grit>, [">= 0"])
    s.add_dependency(%q<pry>, [">= 0.9.8"])
  end
end
