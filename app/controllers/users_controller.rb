class UsersController < ApplicationController
  skip_before_filter :require_login, except: [:show, :edit, :update]
  before_filter :hide_auth_form, only: [:new, :create]

  def new
    @user = User.new
  end

  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end

    @joined_rooms = @user.members.includes(:room).pluck(:room_id, :name)
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
