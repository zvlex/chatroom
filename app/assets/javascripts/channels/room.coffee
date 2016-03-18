App.room = App.cable.subscriptions.create { channel: "RoomChannel", user_id: gon.user_id, room_id: gon.room_id },
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    window.root_vue.$broadcast('signal:addMessage', data['message'])

  send_message: (message) ->
    @perform 'send_message', message: message
