class ManageController < ApplicationController
    before_filter :check_login

private
    def check_login
        if logged_admin_id
            @admin=Manage::Admin.find(logged_admin_id)
        else
            #redirect_to manage_login_url
        end
    end
end