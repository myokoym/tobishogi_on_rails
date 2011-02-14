# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_tobishogi_session',
  :secret      => '6533f10a087b27eea8b2add51c7823fb8496c2285bbe71008a6ba51800c7afe06224f010d5c57451aa2956d64e74a6c6ad2fe65c44f7f905999715643e7961ad'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
