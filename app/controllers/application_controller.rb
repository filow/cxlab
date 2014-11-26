class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_cache
  before_action :set_config

  def set_cache
    @cache=Cache.new
  end

  def set_config
    @config=Cfg.new
  end
  
private
  def admin_login(admin)
    session[:admin_user_id]=admin.id
    session[:admin_user_uid]=admin.uid
  end

  def admin_logout
    session[:admin_user_id]=nil
    session[:admin_user_uid]=nil
  end

  def student_login(student)
    session[:student_user_id] = student.id
    session[:student_user_uid] = student.stuid
  end

  def student_logout
    session[:student_user_id] = nil
    session[:student_user_uid] = nil
  end

  def logged_admin_id
    session[:admin_user_id]
  end

  def logged_student_id
    session[:student_user_id]
  end
end
