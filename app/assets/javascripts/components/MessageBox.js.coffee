window.MessageBox = Vue.extend
  template: '#message-box-tpl'

  components:
    'message': window.Message

  props:
    messages:
      type: Array
      coerce: (value) ->
        JSON.parse value

  ready: ->
    @scrollDown()

  events:
    'signal:addMessage': (data) ->
      @messages = @messagesArray(data)

    'signal:notify': (data) ->
      unless data["messages"]["user_id"] == gon.user_id
        @messages = @messagesArray(data)

  watch:
    messages: ->
      @scrollDown()

  methods:
    messagesArray: (data) ->
      msg for msg in @appendToMessages(data)

    appendToMessages: (data) ->
      @messages.push data['messages']
      @messages

    scrollDown: ->
      message_box = document.getElementById('messages')
      message_box.scrollTop = message_box.scrollHeight if message_box
