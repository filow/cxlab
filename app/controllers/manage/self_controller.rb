class Manage::SelfController < ManageController
  def index
  	@manage_admin = Manage::Admin.find(logged_admin_id)
  end

  def update
  end
end
