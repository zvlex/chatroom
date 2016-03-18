window.MemberBox = Vue.extend
  template: '#member-box-tpl'

  components:
    'member': window.Member

  data: ->
    members:
      online: []
      offline: []

  events:
    'signal:addMember': (data) ->
      @newMember(data)

  methods:
    newMember: (data) ->
      @$set('members', data)
