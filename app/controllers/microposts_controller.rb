class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,      only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "微博发表成功!"
      redirect_to root_url
    else
    	#如果动态流出错，返回当前用户动态
       @feed_items = current_user.microposts.paginate(page: params[:page], per_page: 20)
	render 'static_pages/home'
    end
  end

def destroy
  @micropost.destroy
  flash[:success] = "删除成功！"
  redirect_to request.referrer || root_url
end

private

  def micropost_params
    params.require(:micropost).permit(:content, :picture)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[ :id ])
    redirect_to root_url if @micropost.nil?
  end

end
