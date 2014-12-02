class Index::UserController < IndexController
  before_filter :check_login
  before_action :set_index_student, only: [:index, :email_checked,:email_checked_handler]

  def index

  end

  def email_checked

    #验证邮箱格式是否正确
    if @index_student.valid?
      params={}
      params[:subject] = '创新实验室用户注册验证'
      params[:user] = @index_student
      #生成随机验证字符串
      params[:message] =  Manage::Mail.email_key()
      email = Manage::Mail.new(sid: @index_student.id, mail_key: params[:message])
      #验证信息存入数据库
      if email.save
        IndexStudentMailer.send_mail(params).deliver
        #判断邮件是否发送成功,目前还没有找到好的方法
        if true
          redirect_to user_index_path, :alert => '邮件已经发送，请到邮箱验证'
        else
          redirect_to user_index_path, :alert => '邮件发送失败，请核对邮箱信息后重试发送'
        end
      else
        redirect_to user_index_path, :alert => '邮件发送失败，请重试发送'
      end
    else
      #存入数据库失败
      render :index, :alert => "您的邮箱格式不正确,请修改后重试发送"
    end
  end

  def email_checked_handler
     #验证邮件
     if Manage::Mail.auth_email(@index_student.id,params[:key])
          @index_student.is_email_checked = true
          @index_student.save
           redirect_to user_index_path, :alert =>'邮箱验证成功'
      else
            redirect_to user_index_path, :alert=>'邮箱验证失败,可能链接已失效,您可以重新发送进行验证'
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
