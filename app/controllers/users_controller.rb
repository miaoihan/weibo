class UsersController < ApplicationController
  before_action :logged_in_user, only: [ :index, :edit, :update, :destroy]  #只有登陆后才可以操作
  before_action :correct_user,     only: [ :edit, :update]   #自己修改自己的
  before_action :admin_user,      only: :destroy                #只让管理员删除用户

  def  index
    @users = User.paginate(page: params[ :page], per_page: 20)
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[ :id ])
  #debugger
  end
	
  def create
  	@user = User.new(user_params)		
	if @user.save
              log_in @user   #  注册后直接登陆
		flash[ :success] = "欢迎来到鲁克微博！"
		redirect_to @user
		#redirect_to user_url(@user)
	  	else
	  		render 'new'
	end  	
  end
  
  def edit
    @user = User.find(params[ :id ])
  end

  def update
    @user = User.find(params[:id ])
    if @user.update_attributes(user_params)
      flash[:success] = "修改成功"
      redirect_to @user
   else
      render 'edit'
   end
  end

  def destroy
    User.find(params[ :id ]).destroy
    flash[ :success ] = "删除成功"
    redirect_to users_url
  end

  private
    def user_params
    	params.require( :user ).permit( :name, :email, :password, 
  									:password_confirmation)
    end

#事前过滤器：

  #确保用户已登录  
  def logged_in_user
    unless logged_in?
      store_location
      flash[ :danger] = "登录后才可查看哦"
      redirect_to login_url
    end
  end
  
  #确保是当前用户
  def correct_user
    @user = User.find(params[ :id ])
    redirect_to(root_url) unless current_user?(@user)
  end

  #确保是管理员
  def admin_user
    redirect_to(root_url) unless current_user.admin?
    
  end
end
