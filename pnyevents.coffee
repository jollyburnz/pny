if Meteor.isClient
  Meteor.startup ->
    Meteor.call 'getfbphotos', (err, res) ->
      if err?
        console.log 'err', err
      else
        console.log 'res', res
        aaa = JSON.parse(res.content)
        console.log aaa
        Session.set 'facebook', aaa.data

  Template.whatever.photos = ->
    Session.get 'facebook'

  Template.whatever.rendered = ->
    window.onload = ->
      console.log 'load!'
      setTimeout ->
        $('#overlay').animate
          opacity: 0
      , 1000
      

    $('#fbphotos').isotope
      layoutMode : 'masonry'

    if Session.get 'facebook'
      console.log "jquery!"
      profile = new Object()
      profile.largeimage = Array
      profile.smallimage = Array
      profile.h = jQuery(window).height()
      profile.w = jQuery(window).width()
      profile.navh = jQuery("#container .navbar-static-top").height()

      profile.largeHeaders = jQuery(window).height() - jQuery(window).height() * .1
      profile.largeHeaders = 450  if profile.largeHeaders < 450

      jQuery(".fullwidthimage").css height: profile.largeHeaders / 1.45
      jQuery(".fullwidthimage .title > div").css height: profile.largeHeaders / 1.45
      jQuery(".home .fullwidthimage.home-logo").css #, backgroundSize: '100% auto'
        height: profile.largeHeaders + jQuery("header .nav-main").height()
        backgroundPosition: "center center"

      jQuery(".home .fullwidthimage.home-logo .title > div").css height: profile.largeHeaders + jQuery("header .nav-main").height()

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
        #console.log yo, 'yooo'
        yo


# code to run on server at startup
