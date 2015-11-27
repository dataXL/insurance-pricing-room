# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("i.ion-paintbucket").click ->
    if $(".main-sidebar").attr("id") is "sidebar-flat-dark"
      $(".main-sidebar").attr "id", "sidebar-flat"
    else
      $(".main-sidebar").attr "id", "sidebar-flat-dark"
