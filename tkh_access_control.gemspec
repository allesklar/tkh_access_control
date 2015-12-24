$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "tkh_access_control/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "tkh_access_control"
  s.version     = TkhAccessControl::VERSION
  s.authors     = ["Swami Atma"]
  s.email       = ["swami@TenThousandHours.eu"]
  s.homepage    = "https://github.com/allesklar/tkh_access_control"
  s.summary     = "Simple authentication and authorization Rails engine."
  s.description = "A Rails engine for access control authentication and authorization customized for Ten Thousand Hours and its tkh_cms gem suite."
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md", "CHANGELOG.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "> 4.0"
  s.add_dependency 'bcrypt'
  s.add_dependency "simple_form"
  s.add_dependency 'stringex'

  s.add_development_dependency "sqlite3"
end
