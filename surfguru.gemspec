
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "surfguru/version"

Gem::Specification.new do |spec|
  spec.name          = "surfguru"
  spec.version       = Surfguru::VERSION
  spec.authors       = ["'Emily Welsch'"]
  spec.email         = ["'emwelsch@gmail.com'"]

  spec.summary       = %q{A listing of surfing beaches around the world.}
  spec.description   = %q{CLI data gem app that scrapes and returns a list of surfing beaches around the world, along with detailed
                          information about the surf conditions at each location, from the Surfline webpage. http://www.surfline.com/}
  spec.homepage      = "https://github.com/emilywelsch/surfguru.git"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = ["surfguru"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", ">= 0"
  spec.add_development_dependency "nokogiri", ">= 0"
  spec.add_development_dependency "pry", ">= 0"
  spec.add_development_dependency "colorize", ">= 0"


end
