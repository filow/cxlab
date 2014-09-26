class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private
  def admin_logged?
    # session[:admin_user]
  end

  def admin_login(admin)
    session[:admin_user]=admin.to_json
  end

  def admin_logout

  end
end
