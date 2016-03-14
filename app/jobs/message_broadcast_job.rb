class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "room_channel", message: render_messages(message)
  end

  private

    def render_messages(message)
      ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
    end
end
