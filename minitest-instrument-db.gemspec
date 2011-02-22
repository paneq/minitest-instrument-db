# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "minitest-instrument-db/version"

Gem::Specification.new do |s|
  s.name        = "minitest-instrument-db"
  s.version     = Minitest::Instrument::Db::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Robert Pankowecki"]
  s.email       = ["robert.pankowecki@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Store information about speed of test execution provided by minitest-instrument in database}
  s.description = %q{Store information about speed of test execution provided by minitest-instrument in database}

  s.rubyforge_project = "minitest-instrument-db"

  s.required_rubygems_version = ">= 1.3.6"
  s.add_dependency "activerecord", "~> 3.0"
  s.add_development_dependency "bundler", "~> 1.0.0"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
