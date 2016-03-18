class RoomMemberStatusJob < ApplicationJob
  queue_as :default

  def perform(members, room_id)
    ActionCable.server.broadcast "user_status_channel_#{room_id}", members: members
  end
end
