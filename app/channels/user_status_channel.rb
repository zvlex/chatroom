# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class UserStatusChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_status_channel"

    if valid_params?(params)
      RMemberStatusService.new(params).mark_as_online

      Rails.logger.info('>>> Subscribed!')
    end
  end

  def unsubscribed
    if valid_params?(params)
      RMemberStatusService.new(params).go_offline

      Rails.logger.info('>>> Unsubsribed!')
    end
  end

  def valid_params?(data)
    !!data[:room_id] && !!data[:user_id]
  end
end
