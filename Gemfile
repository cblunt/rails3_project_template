# Gemfile
source 'http://gemcutter.org'

gem "rails", "3.0.0.beta"
gem "sqlite3-ruby", :require => "sqlite3"

# Require the haml gem for rendering HAML templates and SASS stylesheets
gem "haml"

# FactoryGirl and Shoulda Rails 3 development branches from github
group :thoughtbot do
  gem "shoulda", :git => "git://github.com/sinefunc/shoulda.git",
                 :branch => "rails3",
                 :require => "shoulda"

  gem 'factory_girl', :git => 'git://github.com/thoughtbot/factory_girl.git',
                      :branch => 'rails3',
                      :require => "factory_girl"
end

group :test do
  # Install development release of rspec (includes rspec-rails)
  gem "rspec-rails", ">= 2.0.0.a9"
  gem "webrat"
  gem "mocha"
end
