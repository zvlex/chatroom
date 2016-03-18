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
      @messages = (msg for msg in @appendToMessages(data))

  watch:
    messages: ->
      @scrollDown()

  methods:
    appendToMessages: (data) ->
      @messages.push data['messages']
      @messages

    scrollDown: ->
      message_box = document.getElementById('messages')
      message_box.scrollTop = message_box.scrollHeight if message_box
