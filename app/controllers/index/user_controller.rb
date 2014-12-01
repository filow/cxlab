class Index::UserController < IndexController
  before_filter :check_login
  before_action :set_index_student, only: [:index, :email_checked,:email_checked_handler]

  def index

  end

  def email_checked

    params={}
    params[:subject] = '创新实验室用户注册验证'
    params[:user] = @index_student
   
    #生成的验证码
    params[:message] =  Manage::Student.encrypt_email(@index_student.stuid,@index_student.email)

    IndexStudentMailer.send_mail(params).deliver
    redirect_to user_index_path, :alert => '邮件已经发送，请到邮箱验证'
  end

  def email_checked_handler
     #验证邮件
     if Manage::Student.auth_email(@index_student.stuid,params[:key])
          @index_student.is_email_checked = true
          @index_student.save
           redirect_to user_index_path, :alert =>'邮件验证成功'
      else
            redirect_to user_index_path
     end
  end

  private
      def check_login
          redirect_to login_url unless logged_student_id
      end

      def set_index_student
         @index_student = Manage::Student.find(logged_student_id)
      end
 
end
