class MessageNotificationsService
  attr_accessor :msg_type, :user

  DEFAULT_BOT_NAME = 'Channel'

  MESSAGE_TYPES = {
    joined: "joined room",
    left: "left room"
  }

  def initialize(user_id, msg_type)
    @msg_type = msg_type
    @user = User.find(user_id)
  end

  def message
    {
      username: DEFAULT_BOT_NAME,
      content: generate_content_message,
      created_at: "#{Time.now.strftime("%d %B %Y %H:%M")}",
      user_id: user.id
    }
  end

  def generate_content_message
    "#{user.username} #{MESSAGE_TYPES[msg_type]}"
  end
end