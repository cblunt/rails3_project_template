# Require extensions
require 'lib/authenticating_controller'
require 'lib/is_user'

# Load additional configuration
require 'yaml'
APP = YAML.load_file("#{Rails.root}/config/application.yml")[Rails.env] || {}
APP = HashWithIndifferentAccess.new(APP)
