# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("i.ion-paintbucket").click ->
    if $(".main-sidebar").attr("id") is "sidebar-flat-dark"
      $(".main-sidebar").attr "id", "sidebar-flat"
    else
      $(".main-sidebar").attr "id", "sidebar-flat-dark"

  if $("#wizard-first").length
    $(".header .steps .step").removeClass("active").filter(":lt(1)").addClass "active"
    $("input[type=file]").change (e) ->
      $(".form-group").children("label").text $(this).prop("files")[0]["name"]

    $("img").mouseover(->
      src = $(this).attr("src").match(/[^\.]+/) + "hover.png"
      $(this).attr "src", src
    ).mouseout ->
      src = $(this).attr("src").replace("hover.png", ".png")
      $(this).attr "src", src

  else if $("#wizard-second").length
    $(".header .steps .step").removeClass("active").filter(":lt(2)").addClass "active"
    $plans = $(".form-wizard .plans .plan")
    $plans.click ->
      if $(this).hasClass("selected")
        filter = $(this).text()
        $hiddenInput = $("<input/>",
          type: "hidden"
          name: "filters[]"
          id: "filters_"
          value: $.trim(filter)
        )
        $(this).find(".select").prepend $hiddenInput
        $(this).removeClass "selected"
      else
        $(this).find("input:hidden").remove()
        $(this).addClass "selected"

  else if $("#wizard-third").length
    $(".header .steps .step").removeClass("active").filter(":lt(4)").addClass "active"
