class MessagesSerializer < ActiveModel::Serializer
  attributes :id, :username, :content, :created_at

  def username
    object.user.username
  end

  def created_at
    object.created_at.strftime("%d %B %Y %H:%M")
  end
end
