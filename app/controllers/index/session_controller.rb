class Index::SessionController < ApplicationController
  '''
    index控制器用于显示用户登录失败后的页面，会给用户失败的错误信息，以及登陆框、忘记密码等按钮。
  '''
  def index

  end

  '''
    create控制器用于在用户登录时处理表单数据，与系统内的数据对比，产生登录结果。同时应当在session中产生用户登录标志信息。登录成功跳转到user#index,失败就是sessio#index
  '''
  def create
  end

  '''
    logout控制器用于在用户退出登录时从session中清除用户登录标志信息，跳转到首页
  '''
  def logout
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
