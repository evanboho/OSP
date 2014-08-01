# Be sure to restart your server when you modify this file.
if ENV["RAILS_ENV"] == "production"
  OSP::Application.config.session_store :cookie_store, key: '_OSP_session'
else
  OSP::Application.config.session_store :cookie_store, key: '_OSP_session' #, :domain => "ourstoryproject.org"
end

OSP::Application.config.secret_key_base = '0ff38ebf08bd88fd08ba4d63459c6c84220c6622ced29a9cd172ac57b72008cb6bcd5e448d7c2d8775c6ad5122a5ded4d7f506ec22720bf6a15100e2560a332a'
# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# OSP::Application.config.session_store :active_record_store
