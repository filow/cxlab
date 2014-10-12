class Manage::SelfController < ManageController
  def index
  	@manage_admin = Manage::Admin.find(logged_admin_id)
  end

  def update
  	respond_to do |format|
      if @manage_admin.update(manage_admin_params)

        format.html { redirect_to @manage_admin, notice: '管理员信息更新成功.' }
        format.json { render :show, status: :ok, location: @manage_admin }
      else
        format.html { render :edit }
        format.json { render json: @manage_admin.errors, status: :unprocessable_entity }
      end
  	end
  end
end
