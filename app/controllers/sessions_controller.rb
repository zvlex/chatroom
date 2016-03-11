class SessionsController < ApplicationController
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
    logout and redirect_to root_url
  end

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end
end
