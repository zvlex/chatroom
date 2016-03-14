class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
  end

  def send_message(data)
    Message.create! user_id: 1, room_id: 2, content: data['message']
  end
end
