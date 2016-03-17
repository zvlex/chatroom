class RoomChannel < ApplicationCable::Channel
  def subscribed
    if !!params[:room_id]
      stream_from "room_channel"
    end
  end

  def unsubscribed
  end

  def send_message(data)
    room = Room.find_by(id: params[:room_id])

    if current_user && current_user.room_member?(room)
      current_user.messages.create! room: room, content: data['message']
    end
  end
end
