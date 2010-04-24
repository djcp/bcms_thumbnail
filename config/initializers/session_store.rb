# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bcms_thumbnail_session',
  :secret      => '89f925902641a48c7979af8d244425db3ceb6c06f85b579bf3c3fd184f92bdc3f8d1aeb87599e953890aab40956317118ccd99f73bc463b964933e324bb3871d'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
