class RoomMemberStatusService
  attr_reader :user_id, :room_id, :room_users, :status

  STATUSES = {
    room_members: 'members',
    online: 'online'
  }

  def self.default_room_keys(*args)
    args.each do |argument|
      define_method argument do
        "room:#{room_id}:#{STATUSES[argument]}"
      end
    end
  end

  def initialize(options={})
    @user_id = options[:user_id]
    @room_id = options[:room_id]
    @room_users = Room.find(room_id).members.map(&:user)
    @status = {}

    setup_members
  end

  def setup_members
    if $redis.smembers(room_members).empty?
      $redis.sadd(room_members, room_users.map(&:id))
    else
      add_user_to_member_list
    end
  end

  def add_user_to_member_list
    unless $redis.sismember(room_members, user_id)
      $redis.sadd(room_members, user_id)
    end
  end

  def create_room_member_status_job
    RoomMemberStatusJob.perform_later members, room_id
  end

  def mark_as_online
    $redis.smove(room_members, online, user_id)

    send_notification(:joined)
    create_room_member_status_job
  end

  def go_offline
    $redis.smove(online, room_members, user_id)

    send_notification(:left)
    create_room_member_status_job
  end

  def user_collection(members_key)
    result = []

    $redis.smembers(members_key).reject(&:blank?).each do |user_id|
      result << select_room_users(user_id)
    end

    result.flatten.map(&:username).sort
  end

  def select_room_users(user_id)
    room_users.select { |user| user.id == user_id.to_i }
  end

  def send_notification(notification_type)
    status[:messages] = MessageNotificationsService.new(user_id, notification_type).message
  end

  def members
    {
      online: user_collection(online).uniq,
      offline: user_collection(room_members).uniq,
      status: status
    }
  end

  default_room_keys :room_members, :online, :notifications
end
