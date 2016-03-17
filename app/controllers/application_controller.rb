class ApplicationController < ActionController::Base
  include Pundit

  before_action :require_login
  before_action :init_js_data
  before_action :init_signed_cookies_if_logged_in
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def hide_auth_form
      redirect_to root_path if current_user
    end

    def init_signed_cookies_if_logged_in
      cookies.signed[:user_id] = session[:user_id]
    end

    def init_js_data
      gon.is_logged_in = logged_in?

      gon.user_id = logged_in? ? current_user.id : nil

      if controller_name == 'rooms' && action_name == 'show'
        gon.room_id = params[:id]
      end
    end
end
