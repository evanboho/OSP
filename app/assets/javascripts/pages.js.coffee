# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('ul.topnav li a.up').live('click', ->
    $('ul.topnav li ul').slideDown()
    $('ul.topnav li a.up').removeClass('up').addClass('down')
  )
  $('ul.topnav li a.down').live('click', ->
    $('ul.topnav li ul').slideUp()
    $('ul.topnav li a.down').removeClass('down').addClass('up')
  )