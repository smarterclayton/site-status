require ::File.expand_path('../config/environment',  __FILE__)

map '/' do
  run SiteStatus::Application
end
