Meteor.startup ->
  Meteor.methods
    getfbphotos: ->
      @unblock()
      yo = HTTP.call "GET", "http://graph.facebook.com/316854181751282/photos"
      #console.log yo, 'yooo'
      yo
