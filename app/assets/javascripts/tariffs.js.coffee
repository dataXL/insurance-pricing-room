# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  return  unless $("#tariffs").length

  $filters = $(".filters .filter input:checkbox")
  $filters.change ->
    $option = $(this).closest(".filter").find(".filter-option")
    if $(this).is(":checked")
      $option.slideDown 150, ->
        $option.find("input:text:eq(0)").focus()

    else
      $option.slideUp 150


  # Filter dropdown options for Created date, show/hide datepicker or input text
  $dropdown_switcher = $(".field-switch")
  $dropdown_switcher.change ->
    field_class = $(this).find("option:selected").data("field")
    $filter_option = $(this).closest(".filter-option")
    $filter_option.find(".field").hide()
    $filter_option.find(".field." + field_class).show()
    if field_class is "calendar"
      $filter_option.find(".datepicker").datepicker "show"
    else
      $filter_option.find(".field." + field_class + " input:text").focus()

  $table = $("#tariffs-datatable").dataTable
  #$table.dataTable
   # bSort: false
    #sPaginationType: "full_numbers"
    #iDisplayLength: 20
    #aLengthMenu: [ [ 20, 50, 100, -1 ], [ 20, 50, 100, "All" ] ]
    #bDestroy: true

  $("#tariffs-datatable > thead > tr > th").attr "style", "min-width: 120px; vertical-align:middle"
  $("#tariffs-datatable > tbody > tr").hover (->
    $(this).css "background-color", "#fff5c3"
  ), ->
    $(this).css "background-color", "white"


  $("#tariffs-datatable > tbody > tr").hover ->
    $(this).css "background-color", "yellow"
  #$("#tariffs-datatable > thead > tr > th").removeClass("sorting_disabled")

  $("#tariffs-datatable_filter").detach().appendTo "#top-bar"
  $("#tariffs-datatable_paginate").detach().appendTo "#bottom-bar"

  $("#filter").click ->
    $(".filters").animate
      width: "toggle"
    , 500

  jQuery(".best_in_place").best_in_place()
  $("table > tbody > tr").hover (->
    $(this).addClass "hover"
  ), ->
    $(this).removeClass "hover"

  $(".ion-funnel").click ->
    if $("#top-bar").width() is 850
      $(".filters").stop().animate
        width: "0px", 350
      $(".results").stop().animate
        width: "+=260", 350
      $("#top-bar").stop().animate
        width: "+=260", 350
      $("#middle-bar").stop().animate
        width: "+=260", 350
      $("#bottom-bar").stop().animate
        width: "+=260", 350
    else if $("#top-bar").width() is 1110
      $(".filters").stop().animate
        width: "250px", 350
      $(".results").stop().animate
        width: "-=260", 350
      $("#top-bar").stop().animate
        width: "-=260", 350
      $("#middle-bar").stop().animate
        width: "-=260", 350
      $("#bottom-bar").stop().animate
        width: "-=260", 350

  $("div.field input").keyup ->
    id = $(this).attr("id")
    value = $(this).val()
    $("span[data-bip-attribute = '" + id + "']:contains('" + value + "')").closest("tr").show()
    $("span[data-bip-attribute = '" + id + "']:not(:contains('" + value + "'))").closest("tr").hide()




