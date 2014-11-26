class Index::UserController < IndexController
  before_filter :check_login

  def index
  end

  private
      def check_login
          redirect_to login_url unless logged_student_id
      end
  
end
