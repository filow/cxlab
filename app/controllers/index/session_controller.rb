class Index::SessionController < IndexController
  '''
    index控制器用于显示用户登录失败后的页面，会给用户失败的错误信息，以及登陆框、忘记密码等按钮。
  '''
  def index
    render layout: false
  end

  '''
    create控制器用于在用户登录时处理表单数据，与系统内的数据对比，产生登录结果。同时应当在session中产生用户登录标志信息。登录成功跳转到user#index,失败就是sessio#index
  '''
  def create
    #判断用户名密码是否在数据库中存在
    if index_student = Manage::Student.auth(params[:stuid],params[:password])
        student_login(index_student)
        redirect_to user_index_path
    else
      #密码不正确或用户名不存在
      redirect_to login_url,:alert => "不正确的用户名/密码"
    end
  end

  '''
    logout控制器用于在用户退出登录时从session中清除用户登录标志信息，跳转到首页
  '''
  def logout
    student_logout
    redirect_to index_index_path
  end

  '''
    用户忘记密码的页面
  '''
  def forgot

  end
  
  '''
    用户注册页面，只显示填表信息
  '''
  def regist

  end

  '''
    接收用户注册信息，判断合法性，从而创建用户。
  '''
  def regist_handler

  end
end
