class Manage::SelfController < ManageController
  def index
  	@manage_admin = Manage::Admin.find(logged_admin_id)
  end
  #更新管理员数据
  def update
  	@manage_admin = Manage::Admin.find(logged_admin_id)
  	@manage_admin.update(manage_admin_params)
  	redirect_to manage_self_index_path
  end
  def manage_admin_params
      params.permit(:uid, :nickname, :pwd, :email, :desc)
  end
end
