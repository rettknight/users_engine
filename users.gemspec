$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "users/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "users"
  s.version     = Users::VERSION
  s.authors     = ["rettknight"]
  s.email       = ["rodolfosilva@me.com"]
  s.homepage    = "https://github.com/rettknight"
  s.summary     = "User Engine for Apps"
  s.description = "User Model plus everything used in previous system inside an engine"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2.4"

  s.add_development_dependency "sqlite3"
end
