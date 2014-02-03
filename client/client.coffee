Meteor.startup ->
  filepicker.setKey("AO1f1U4OR4ewgjfQ4uy70z");
  
  Meteor.call 'getfbphotos', (err, res) ->
    if err?
      console.log 'err', err
    else
      console.log 'res', res
      aaa = JSON.parse(res.content)
      console.log aaa
      Session.set 'facebook', aaa.data

    Session.set('done', false)

Template.admin.rendered = ->
  window.onload = ->
    console.log 'load!'
    setTimeout ->
      $('#overlay').animate
        opacity: 0
        'z-index': -1
    , 500

  console.log 'ADMIN POWER!'
  filepicker.constructWidget(document.getElementById('photo1'));
  filepicker.constructWidget(document.getElementById('photo2'));
  filepicker.constructWidget(document.getElementById('photo3'));

Template.admin.photo1 = ->
  Photo1.findOne({}, {sort:{date:-1}})

Template.admin.photo2 = ->
  Photo2.findOne({}, {sort:{date:-1}})

Template.admin.photo3 = ->
  Photo3.findOne({}, {sort:{date:-1}})

Template.admin.title2 = ->
  Title2.findOne({}, {sort:{date:-1}})

Template.admin.title3 = ->
  Title3.findOne({}, {sort:{date:-1}})

Template.admin.events
  'change #photo1': (e, t) ->
    #console.log e.files[0], e.files[0].data.filename, e.files[0].url, 'files'
    Photo1.insert
      filename: e.files[0].data.filename
      url: e.files[0].url
      date: new Date()

  'change #photo2': (e, t) ->
    #console.log e.files[0], e.files[0].data.filename, e.files[0].url, 'files'
    Photo2.insert
      filename: e.files[0].data.filename
      url: e.files[0].url
      date: new Date()

  'change #photo3': (e, t) ->
    #console.log e.files[0], e.files[0].data.filename, e.files[0].url, 'files'
    Photo3.insert
      filename: e.files[0].data.filename
      url: e.files[0].url
      date: new Date()

  'keyup #title2': (e, t) ->
    if e.keyCode is 13
      title2 = t.find('#title2').value
      Title2.insert
        title: title2
        date: new Date()

      t.find('#title2').value = "" #blank out field



  'keyup #title3': (e, t) ->
    if e.keyCode is 13
      title3 = t.find('#title3').value
      Title3.insert
        title: title3
        date: new Date()

      t.find('#title3').value = "" #blank out field

Template.whatever.photo1 = ->
  Photo1.findOne({}, {sort:{date:-1}})

Template.whatever.photo2 = ->
  Photo2.findOne({}, {sort:{date:-1}})

Template.whatever.photo3 = ->
  Photo3.findOne({}, {sort:{date:-1}})

Template.whatever.title2 = ->
  Title2.findOne({}, {sort:{date:-1}})

Template.whatever.title3 = ->
  Title3.findOne({}, {sort:{date:-1}})

Template.whatever.photos = ->
  Session.get 'facebook'

Template.whatever.done = ->
  Session.equals 'done', true

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

Template.whatever.events 
  "click #submit": (e,t) ->
    e.preventDefault()
    console.log e, t, 'submit'
    email_address = t.find('#email').value
    console.log email_address

    Emails.insert
      email: email_address

    Meteor.call('sendEmail', email_address)

    Session.set 'done', true