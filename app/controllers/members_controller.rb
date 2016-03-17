class MembersController < ApplicationController
  before_action :require_login

  def create
    @member = current_user.members.build(member_params)
    @member.from_ui = true

    if @member.save
      render json: @member, status: 200
    else
      render json: @member.errors, status: 400
    end
  end

  def member_params
    params.require(:member).permit(:room_id)
  end
end
