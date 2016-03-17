# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class UserStatusChannel < ApplicationCable::Channel
  def subscribed
    begin
      if !!params[:room_id]
        stream_from "user_status_channel_#{params[:room_id]}"

        RoomMemberStatusService.new(params).mark_as_online
      else
        RoomMemberStatusService.new(params).members
      end
    rescue => e
      Rails.logger.debug ">>> #{e}"
    end
  end

  def unsubscribed
    if !!params[:room_id]
      RoomMemberStatusService.new(params).go_offline

      Rails.logger.info('>>> Unsubsribed!')
    end
  end
end
