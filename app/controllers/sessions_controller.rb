class SessionsController < ApplicationController
  skip_before_filter :require_login, except: :destroy
  before_filter :hide_auth_form, except: :destroy

  def new
    @user_session = User.new
  end

  def create
    if login(session_params[:email], session_params[:password])
      redirect_to root_url, success: 'Logged in'
    else
      flash.now[:error] = 'Login failed'
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url
  end

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end
end
