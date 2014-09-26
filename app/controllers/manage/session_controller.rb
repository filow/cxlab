class Manage::SessionController < ApplicationController
  def index
  end

  def create
  	#判断用户名密码是否在数据库中存在
  	if manage_admin = Manage::Admin.auth(params[:name],params[:password])
			session[:user_id]=user.id
			session[:user_name]=user.name
			session[:user_is_admin]=user.is_admin
			redirect_to manage_admins_path
		else
			#密码不正确或用户名不存在
			redirect_to manage_login_url,:alert => "不正确的用户名/密码"
		end
  end
end
