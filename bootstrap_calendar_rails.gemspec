$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bootstrap_calendar_rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bootstrap_calendar_rails"
  s.version     = BootstrapCalendarRails::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Nikita Vasiliev"]
  s.email       = ["sharpyfox@gmail.com"]
  s.homepage    = "https://github.com/sharpyfox/bootstrap_calendar_rails"
  s.summary     = %q{calendar helper for Twitter Bootstrap}
  s.description = %q{bootstrap_calendar_rails allow you to build beautiful calendars with Twitter Bootstrap and Rails}

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
end
