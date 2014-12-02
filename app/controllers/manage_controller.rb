class ManageController < ApplicationController
    before_filter :check_login

private
    def check_login
        if logged_admin_id
            # 从数据库中读取用户信息
            @admin=Manage::Admin.find(logged_admin_id)
            # 如果用户已经被禁用也直接跳转
            unless @admin.is_enabled?
                redirect_to manage_login_url,:alert => "您的账户已被禁用" 
            end
        else
            redirect_to manage_login_url
        end
    end
end