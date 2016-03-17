class UsersController < ApplicationController
  skip_before_filter :require_login, except: [:edit, :update]
  before_filter :hide_auth_form

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      login(user_params[:email], user_params[:password])

      redirect_to root_url, notice: 'Signed In'
    else
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
