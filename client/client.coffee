Meteor.startup ->
  Meteor.call 'getfbphotos', (err, res) ->
    if err?
      console.log 'err', err
    else
      console.log 'res', res
      aaa = JSON.parse(res.content)
      console.log aaa
      Session.set 'facebook', aaa.data

Template.admin.rendered = ->
  window.onload = ->
    console.log 'load!'
    setTimeout ->
      $('#overlay').animate
        opacity: 0
        'z-index': -1
    , 500

Template.whatever.photos = ->
  Session.get 'facebook'

Template.whatever.rendered = ->
  window.onload = ->
    console.log 'load!'
    setTimeout ->
      $('#overlay').animate
        opacity: 0
        'z-index': -1
    , 500

  console.log(Session.get 'facebook')

  #================
  console.log 'fb info loaded!'
  # $('#fbphotos').isotope
  #   layoutMode : 'masonry'

  $container = $("#fbphotos")
  # initialize Isotope
  console.log $container.width()
  $container.isotope
    # options...
    resizable: false # disable normal resizing
    # set columnWidth to a percentage of container width
    masonry:
      columnWidth: $container.width() / 4

  # update columnWidth on window resize
  $(window).smartresize ->
    # update columnWidth to a percentage of container width
    console.log $container.width() / 4
    $container.isotope masonry:
      columnWidth: $container.width() / 4

  #================

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

    jQuery(".fullwidthimage").css height: profile.largeHeaders / 1.2
    jQuery(".fullwidthimage .title > div").css height: profile.largeHeaders / 1.2
    jQuery(".home .fullwidthimage.home-logo").css #, backgroundSize: '100% auto'
      height: profile.largeHeaders + jQuery("header .nav-main").height()
      backgroundPosition: "center center"

    jQuery(".home .fullwidthimage.home-logo .title > div").css height: profile.largeHeaders + jQuery("header .nav-main").height()

    setTimeout ->
      $('#fbphotos').isotope('reLayout')
    , 500

Template.hello.greeting = ->
  "Welcome to pnyevents."

Template.hello.events "click input": ->
  
  # template data, if any, is available in 'this'
  console.log "You pressed the button"  if typeof console isnt "undefined"
