# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_teste_session',
  :secret      => '2e11856dca5aa45c6b7c87933f2816153b623ded7c05917149588995c50ed794bec2102598ee90b3c1f70026ecc51a09dcccbedd57e0f7a8ce83cb0e0368f281'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
