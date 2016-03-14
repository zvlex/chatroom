class RoomMemberStatusService
  attr_reader :user_id, :room_key

  def initialize(options={})
    @user_id = options[:user_id]
    @room_key = "room:#{options[:room_id]}"
  end

  def mark_as_online
    users = $redis_room_users.lrange(room_key, 0, -1).map(&:to_i)

    if !users.include?(user_id) || users.empty?
      activate_user
    end

    RoomMemberStatusJob.perform_later member_list
  end

  def go_offline
    $redis_room_users.lrem(room_key, 0, user_id)

    RoomMemberStatusJob.perform_later member_list
  end

  def activate_user
    $redis_room_users.lpush(room_key, user_id)
  end

  def member_list
    Rails.logger.info '>>> '
    Rails.logger.info $redis_room_users.lrange(room_key, 0, -1)
    $redis_room_users.lrange(room_key, 0, -1)
  end
end
