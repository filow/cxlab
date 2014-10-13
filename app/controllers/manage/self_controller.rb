class Manage::SelfController < ManageController
  def index
  	@manage_admin = Manage::Admin.find(logged_admin_id)
  end
  #更新管理员数据
  def update
  	@manage_admin = Manage::Admin.find(logged_admin_id)
  	Manage::Admin.update(@manage_admin.id,:uid => params[:uid],:nickname=> params[:nickname],:pwd=> params[:pwd],:email=> params[:email],:desc=> params[:desc])
  	redirect_to manage_self_index_path
  end
end
