
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "rack/secure_samesite_cookies/version"

Gem::Specification.new do |spec|
  spec.name          = "rack-secure_samesite_cookies"
  spec.version       = Rack::SecureSamesiteCookies::VERSION
  spec.authors       = ["Doug Martin"]
  spec.email         = ["dmartin@concord.org"]

  spec.summary       = %q{Adds secure and samesite attriutes to cookies}
  spec.description   = %q{Adds secure and samesite attriutes to cookies}
  spec.homepage      = "https://github.com/concord-consortium/secure-samesite-cookies"
  spec.license       = "MIT"

  spec.add_dependency "rack", "~> 1.4.7"

  if spec.respond_to?(:metadata)
    # Prevent pushing this gem to RubyGems.org by using fake host url
    spec.metadata["allowed_push_host"] = "https://no-such-subdomain.concord.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 1.10"
  spec.add_development_dependency "rake", ">= 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "rack-test"
end
