class RoomMemberStatusJob < ApplicationJob
  queue_as :default

  def perform(members, room_id)
    ActionCable.server.broadcast "user_status_channel_#{room_id}", members: render_members(members)
  end

  private

    def render_members(members)
      ApplicationController.renderer.render(partial: 'rooms/members', locals: { members: members })
    end
end
