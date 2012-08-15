class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :current_user?

  def current_user
    current_admin
  end

  def current_user?
    admin_signed_in?
  end


end
