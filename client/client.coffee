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
  Session.set 'city', 'New York'

  $('#datetimepicker').datetimepicker
    timepicker:false
    inline:true
    onChangeDateTime: (dp, $input) ->
      date = $input.val()
      console.log date
      Session.set 'date', Date.parse(date)

  $("#desc").cleditor({ width:500, height:250, controls: "" })[0].focus()

  window.onload = ->
    console.log 'load!'
    setTimeout ->
      $('#overlay').animate
        opacity: 0
        'z-index': -1
    , 500

  console.log 'ADMIN POWER!'
  filepicker.constructWidget(document.getElementById('photo1'))
  filepicker.constructWidget(document.getElementById('photo2'))
  filepicker.constructWidget(document.getElementById('photo3'))
  filepicker.constructWidget(document.getElementById('flyer'))

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

Template.admin.flyer = ->
  Session.get 'flyer'

Template.admin.events
  'click #add-event': (e, t) ->
    console.log (Session.get 'date')
    venue1 = $('#venue').val()
    
    Events.insert
      date: Session.get 'date'
      location: Session.get 'city'
      venue: $('#venue').val()
      description: $('#desc').val()
      url: 'http://placekitten.com/g/200/400'
      #url: Session.get 'flyer'

  'change #choose-city': (e, t) ->
    city = $('#choose-city').val()
    Session.set 'city', city

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


Template.events.rendered = ->
  window.onload = ->
    console.log 'load!'
    setTimeout ->
      $('#overlay').animate
        opacity: 0
        'z-index': -1
    , 500

Template.events1.past = ->
  Session.equals 'evt', 'past'

Template.events1.today = ->
  Session.equals 'evt', 'today'

Template.events1.next = ->
  Session.equals 'evt', 'next'

Template.events1.upcoming = ->
  Session.equals 'evt', 'upcoming'

Template.events1.choose = ->
  Session.get 'choose'

Template.events1.eventsofpast = ->
  chosen = Session.get 'choose'
  Events.find({location: chosen, date:{"$lte": monday}})

Template.events1.eventsthisweek = ->
  chosen = Session.get 'choose'
  Events.find({location: chosen, date: {"$gte": monday, "$lte": sunday}})

Template.events1.eventsnextweek = ->
  chosen = Session.get 'choose'
  Events.find({location: chosen, date: {"$gte": next_monday, "$lte": next_sunday}})

Template.events1.allupcoming = ->
  chosen = Session.get 'choose'
  console.log tomorrow
  Events.find({location: chosen, date: {"$gte": tomorrow}})


Template.events1.rendered = ->
  if Session.equals 'evt', 'past'
    console.log 'PAST'
    $("#past").addClass 'active'

  else if Session.equals 'evt', 'today'
    console.log 'TODAY'
    $("#this").addClass 'active'

  else if Session.equals 'evt', 'next'
    console.log 'NEXT'
    $("#next").addClass 'active'

  else if Session.equals 'evt', 'upcoming'
    console.log 'UPCOMING'
    $("#upcomings").addClass 'active'

  if Session.equals 'choose', 'New York'
    $('body').backstretch('newyork.jpg')

  else if Session.equals 'choose', 'Boston'
    $('body').backstretch('boston.jpg')

  else if Session.equals 'choose', 'DC'
    $('body').backstretch('dc12.jpg')

  window.monday = moment().weekday(0)._d
  window.sunday = moment().weekday(7)._d
  window.next_monday = moment().weekday(7)._d
  window.next_sunday = moment().weekday(14)._d
  window.tomorrow = moment().add('d', 1)._d

  window.onload = ->
    Session.set 'evt', 'today'
    Session.set 'choose', 'New York' #default is New York
    console.log 'load!'


    setTimeout ->
      $('#overlay').animate
        opacity: 0
        'z-index': -1
    , 500

Template.events1.events
  'change #choose': (e, t) ->
    console.log 'asdfasd'
    Session.set 'choose', $('#choose').val()

  "click #past": (e, t) ->
    console.log 'past'
    Session.set 'evt', 'past'
  
  "click #this": (e, t) ->
    console.log 'this'
    Session.set 'evt', 'today'
  
  "click #next": (e, t) ->
    console.log 'next'
    Session.set 'evt', 'next'

  "click #upcomings": (e, t) ->
    console.log 'upcoming'
    Session.set 'evt', 'upcoming'

Template.eventItem.day = ->
  console.log @.date, moment(@.date).format('dddd')
  moment(@.date).format('dddd, MMM Do')

Template.eventItem.rendered = ->
  $(@.find('.front')).backstretch(@.data.url)

Template.pastEventItem.day = ->
  console.log @.date, moment(@.date).format('dddd')
  moment(@.date).format('dddd, MMM Do')

Template.pastEventItem.rendered = ->
  $(@.find('.front')).backstretch(@.data.url)


Template.contactus.rendered = ->
  $('body').backstretch('newyork.jpg')

  window.onload = ->
    console.log 'load!'
    setTimeout ->
      $('#overlay').animate
        opacity: 0
        'z-index': -1
    , 500