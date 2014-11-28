class Index::UserController < IndexController
  before_filter :check_login

  def index
      @student=Manage::Student.find(logged_student_id)
  end

  private
      def check_login
          redirect_to login_url unless logged_student_id
      end
  
end
