window.MessageBox = Vue.extend
  template: '#message-box-tpl'

  components:
    'message': window.Message

  data: ->
    msg_array: @messages

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
      document.getElementById('messages')
      messages.scrollTop = messages.scrollHeight if messages
