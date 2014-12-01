class IndexStudentMailer < ActionMailer::Base
  default from: "1420646999@qq.com"

  def send_mail(params)
    
    @user = params[:user]
    @params = params
    mail(
        :subject => params[:subject], 
        :from => "1420646999@qq.com", 
        :to => @user.email , 
        :date => Time.now
      )
  end 
  
end
