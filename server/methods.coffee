Meteor.startup ->
  process.env.MAIL_URL = "smtp://postmaster@sandbox18028.mailgun.org:9q3nxrc3rs88@smtp.mailgun.org:587"

  Meteor.methods
    getfbphotos: ->
      @unblock()
      yo = HTTP.call "GET", "http://graph.facebook.com/466221280147904/photos"
      #console.log yo, 'yooo'
      yo

    sendEmail: (email) ->  
      # send the email!
      console.log email, 'email'
      Email.send
        to: email
        from: "newsletter@pnyevents.com"
        subject: "[PNY Events] Thank you for joining our newsletter!"
        text: "We'll let keep you posted with the hottest parties in NYC."
