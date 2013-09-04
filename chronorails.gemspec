$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chronorails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chronorails"
  s.version     = Chronorails::VERSION
  s.authors     = ["Simon Hildebrandt"]
  s.email       = ["simonhildebrandt@gmail.com"]
  s.homepage    = "http://www.simonhildebrandt.com/chronorails"
  s.summary     = "Chronorails adds chronic and chronic_duration support to your Rails models."
  s.description = "Chronorails handles adding virtual attributes to your models (with suitable validations, etc) allowing you to set date and duration fields with natural language text."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.13"
  s.add_dependency "chronic"
  s.add_dependency "chronic_duration"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
