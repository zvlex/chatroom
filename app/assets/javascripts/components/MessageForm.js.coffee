window.MessageForm = Vue.extend
  props:
    isRoomMember:
      type: Boolean
      required: true

  data: ->
    message: ''

  methods:
    joinRoom: (room_id) ->
      unless gon.user_id
        location.href = '/sign_in'
        return

      # TODO: JS rotes???
      resource = @$resource('/members')

      resource.save({}, member: { room_id: room_id }).then ((response) ->
        @isRoomMember = !@isRoomMember
      ), (response) ->
        console.log 0

    sendMessage: ->
      if @message != ''
        App.room.send_message @message
        @message = ''
