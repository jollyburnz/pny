Meteor.startup ->
  Meteor.methods
    getfbphotos: ->
      @unblock()
      yo = HTTP.call "GET", "http://graph.facebook.com/316854181751282/photos"
      #console.log yo, 'yooo'
      yo

    sendEmail: (to, from, subject, text) ->
      check [to, from, subject, text], [String]

      # Let other method calls from the same client start running,
      # without waiting for the email sending to complete.
      @unblock()
      Email.send
        to: to
        from: from
        subject: subject
        text: text
        , (err) ->
          console.log err

      console.log "Sent e-mail"
