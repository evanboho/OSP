# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  slide = (timeout = 0) ->
    $('ul.subnav.up').delay(timeout).slideUp()
    $('ul.subnav.down').slideDown()

  $('body').on 'click', 'ul.topnav li a.drop', ->
    subnav = '#' + $(@).attr('id') + '-' + 'subnav'
    if $(subnav).hasClass('down')
      $(subnav).removeClass('down').addClass('up')
    else
      $('.subnav').removeClass('down').addClass('up')
      $(subnav).addClass('down').removeClass('up')
    slide()

  .on 'mouseleave', 'ul.topnav', ->
    $('.subnav').removeClass('down').addClass('up')
    slide(1000)



  $('#flash p').delay(2500).fadeOut(700)
