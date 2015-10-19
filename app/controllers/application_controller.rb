class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  before_filter :set_locale 
    
    def set_locale 
      I18n.locale = params[:locale] || I18n.default_locale 
    end 

  private
  #确保用户已登录  
    def logged_in_user
      unless logged_in?
        store_location
        flash[ :danger] = "登录后才可查看哦！"
        redirect_to login_url
      end
    end

end
