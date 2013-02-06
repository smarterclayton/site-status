unless defined? Rails.application
  ENV["RAILS_ENV"] = "test"

  require File.expand_path("../rails_app/config/environment.rb",  __FILE__)
  require "rails/test_help"
end

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

