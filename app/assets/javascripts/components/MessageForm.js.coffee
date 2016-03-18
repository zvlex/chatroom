window.MessageForm = Vue.extend
  template: '#message-form-tpl'

  props:
    isRoomMember:
      type: Boolean
    roomId:
      require: true

  data: ->
    message: ''

  methods:
    joinRoom: ->
      unless gon.user_id
        location.href = '/sign_in'
        return

      # TODO: JS rotes???
      resource = @$resource('/members')

      resource.save({}, member: { room_id: @roomId }).then ((response) ->
        @isRoomMember = !@isRoomMember
      ), (response) ->
        console.log 0

    sendMessage: ->
      if @message != ''
        App.room.send_message @message
        @message = ''
