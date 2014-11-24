class Index::UserController < IndexController
  before_filter :check_login

  def index
  end

  private
      def check_login
          if logged_student_id
              # 从数据库中读取用户信息
            @student=Manage::Student.find(logged_student_id)
          else
            redirect_to index_login_url
          end
      end
  
end
