$:.push File.expand_path("../lib", __FILE__)


# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acl_dog"
  s.version     = "0.0.1"
  s.authors     = ["Blas Soto","Jorge Sazo"]
  s.email       = ["blassoto@gmail.com"]
  s.homepage    = ""
  s.summary     = "ACL and Login Gem"
  s.description = "ACL and Login Gem"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.0"

  s.add_development_dependency "sqlite3"
end
