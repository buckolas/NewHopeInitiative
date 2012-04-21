class UserSession < Authlogic::Session::Base
  generalize_credentials_error_messages "Invalid login information provided."
  logout_on_timeout true
end