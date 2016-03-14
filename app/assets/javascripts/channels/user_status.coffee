App.user_status = App.cable.subscriptions.create { channel: "UserStatusChannel", room_id: gon.room_id, user_id: gon.user_id },
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $("#members").html data["members"]
