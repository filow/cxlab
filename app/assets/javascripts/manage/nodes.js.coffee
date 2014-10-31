# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
    $('div.node-block span').hide()
    $('div.node-block').mouseenter -> 
        $(this).find('span').show()
    .mouseleave ->
        $(this).find('span').hide()

