if Meteor.isClient
  Meteor.startup ->
    Meteor.call 'getfbphotos', (err, res) ->
      if err?
        console.log 'err', err
      else
        console.log 'res', res
        aaa = JSON.parse(res.content)
        console.log aaa
        Session.set 'test', aaa.success


  Template.hello.greeting = ->
    "Welcome to pnyevents."

  Template.hello.events "click input": ->
    
    # template data, if any, is available in 'this'
    console.log "You pressed the button"  if typeof console isnt "undefined"

if Meteor.isServer
  Meteor.startup ->
    Meteor.methods
      getfbphotos: ->
        @unblock()
        yo = HTTP.call "GET", "http://graph.facebook.com/316854181751282/photos"
        console.log yo, 'yooo'
        yo


# code to run on server at startup
