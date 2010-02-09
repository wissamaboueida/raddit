# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_raddit_session',
  :secret      => 'a9f80ef4326478e96e002066342284f9185c3ce111f92484b3e07ce2900a3d575c1f0daed10a8b5f827cb50d213a1c99e672398fb4cc57ba84dcf2913bdc4fa8'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
