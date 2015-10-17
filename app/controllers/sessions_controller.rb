class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[ :session ][ :email] .downcase)
  	if user && user.authenticate(params[ :session ][ :password ])# 除了 nil 和 false 之外的所有对象都被视作 true
  	   # 登入并记住登录状态,然后重定向到用户的资料页面
  	   log_in user 		# => session[:user_id] = user.id
  	 #   remember user
	 #   redirect_to user
	   params[ :session ][ :remember_me ] == '1' ? remember(user) : forget(user)
	   redirect_back_or user
  	else
  	   # =>   flash[:danger] = 'Invalid email/password combination' # 不完全正确
  	   flash.now[:danger] = '不正确的邮箱或密码'
	   render 'new'	  		
  	end
  end
  
  def destroy
 #  	session.delete(:user_id)		
 #   @current_user = nil
	log_out	if logged_in?	# => 销毁用户Session
  	redirect_to root_url
  end
end
