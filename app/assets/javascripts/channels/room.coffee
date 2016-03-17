App.room = App.cable.subscriptions.create { channel: "RoomChannel", user_id: gon.user_id, room_id: gon.room_id },
  connected: ->
    # Called when the subscription is ready for use on the server
    @scrollDown()

  disconnected: ->
    # Called when the subscription has been terminated by the server
    @scrollDown()

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    $('#messages').append data['message']
    @scrollDown()

  scrollDown: ->
    # TODO: Move to Vue.js
    messages  = document.getElementById('messages')
    messages.scrollTop = messages.scrollHeight if messages

  send_message: (message) ->
    @perform 'send_message', message: message
