class IndexController < ApplicationController
    before_action :set_student


private
    # 从数据库中读取用户信息
    def set_student
        @student=Manage::Student.find(logged_student_id) if logged_student_id 
    end

end