# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  $('a').live('click', ->
    unless ($(this).hasClass('drop'))
      $('ul.topnav li ul').slideUp()
      $('ul.topnav li a.down').removeClass('down').addClass('up')
  )

  $('ul.topnav li a.drop').live('click', ->
    $('ul.topnav li ul.subnav').slideDown() #.delay(5000).slideUp()
    $('ul.topnav li a.drop').addClass('down').delay(1000)
    # $('ul.topnav li a.down').delay(5000).removeClass('down').addClass('up')
  )

  $('ul.topnav li a.down').live('click', ->
    $('ul.topnav li ul').slideUp()
    $('ul.topnav li a.down').removeClass('down').addClass('up')
  )

  $('ul.subnav').live('mouseleave', ->
    $('ul.topnav li ul').delay(500).slideUp()
    $('ul.topnav li a.down').removeClass('down').addClass('up')
  )



  #    $('ul.topnav li ul').slideUp()
  #    $('ul.topnav li a.down').removeClass('down').addClass('up')
  #)
