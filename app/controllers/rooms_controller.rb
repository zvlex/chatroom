class RoomsController < ApplicationController
  skip_before_filter :require_login, expect: [:new, :create, :edit]

  def index
    @rooms = Room.order(created_at: :desc)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.order(created_at: :desc)
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)

    if @room.save
      redirect_to @room, notice: 'Room created'
    else
      render :new
    end
  end

  def edit
  end

  private
    def room_params
      params.require(:room).permit(:name, :description)
    end
end
