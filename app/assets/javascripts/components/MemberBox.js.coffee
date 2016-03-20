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
      window.root_vue.$broadcast('notify', data)

  methods:
    newMember: (data) ->
      @notify(data)
      @$set('members', data)

    notify: (data) ->
      window.root_vue.$broadcast('signal:notify', data['status'])
      @deleteElement(data, 'status')

    deleteElement: (data, element) ->
      delete data[element]
