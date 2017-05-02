$:.push File.expand_path("../lib", __FILE__)

require "efast/version"

Gem::Specification.new do |s|
  s.name          = "efast"
  s.version       = EFast::VERSION
  s.authors       = ["Derek.Luo"]
  s.email         = ["luoding@jinanlongen.cn"]
  s.homepage      = "https://github.com/derekluo/efast-ruby"
  s.summary       = "An simple efast client gem"
  s.description   = "An simple efast client gem"
  s.license       = "MIT"

  s.require_paths = ["lib"]

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_runtime_dependency "rest-client"
  s.add_runtime_dependency "activesupport", '>= 3.2'
  s.add_runtime_dependency "json"

  s.add_development_dependency "bundler", '~> 1'
  s.add_development_dependency "rake", '~> 10'
  s.add_development_dependency "fakeweb", '~> 1'
  s.add_development_dependency "minitest", '~> 5'
end
