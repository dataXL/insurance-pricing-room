# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$("form#sign_up_user").bind "ajax:success", (e, data, status, xhr) ->
    if data.success
      alert 'success!'
      #$('#sign_up').modal('hide')
      #$('#sign_up_button').hide()
      #$('#submit_comment').slideToggle(1000, "easeOutBack" )
    else
      alert 'failure!'

