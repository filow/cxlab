class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

private
  def admin_login(admin)
    session[:admin_user_id]=admin.id
    session[:admin_user_uid]=admin.uid
  end

  def admin_logout
    session[:admin_user_id]=nil
    session[:admin_user_uid]=nil
  end

  def logged_admin_id
    session[:admin_user_id]
  end
end
