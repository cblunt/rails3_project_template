# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_my_app_session',
  :secret => 'ca803a22f551d9b580c014ac99737823300b058c2b9d2dbb6915fe2419996fd9fbae822c6f10853bfa7b4fce1060caf011cb451c8be582f95dade9300bb07ddd'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
