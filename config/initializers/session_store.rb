# Be sure to restart your server when you modify this file.
if ENV["RAILS_ENV"] == "production"
  OSP::Application.config.session_store :cookie_store, key: '_OSP_session'
else
  OSP::Application.config.session_store :cookie_store, key: '_OSP_session' #, :domain => "ourstoryproject.org"
end
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# OSP::Application.config.session_store :active_record_store
