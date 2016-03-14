class RoomMemberStatusJob < ApplicationJob
  queue_as :default

  def perform(members)
    ActionCable.server.broadcast "user_status_channel", members: render_members(members)
  end

  private

    def render_members(members)
      ApplicationController.renderer.render(partial: 'rooms/members', locals: { members: members })
    end
end
