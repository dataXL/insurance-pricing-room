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

  $table = $("#tariffs-datatable")
  $table.dataTable
    paging: "full_numbers"
    iDisplayLength: 20
    aLengthMenu: [ [ 20, 50, 100, -1 ], [ 20, 50, 100, "All" ] ]
    bDestroy: true

  $("#tariffs-datatable_filter").detach().appendTo ".top-bar"
  $("#tariffs-datatable_paginate").detach().appendTo ".bottom-bar"

  $("#filter").click ->
    $(".filters").animate
      width: "toggle"
    , 500

  jQuery(".best_in_place").best_in_place()

  $(".ion-funnel").click ->
    if $(".top-bar").width() is 850
      $(".ion-funnel").css("color","gray")
      $(".filters").stop().animate
        width: "0px", 350
      $(".results").stop().animate
        width: "+=260", 350
      $(".top-bar").stop().animate
        width: "+=260", 350
      $(".middle-bar").stop().animate
        width: "+=260", 350
      $(".bottom-bar").stop().animate
        width: "+=260", 350
    else if $(".top-bar").width() is 1110
      $(".ion-funnel").css("color","black")
      $(".filters").stop().animate
        width: "250px", 350
      $(".results").stop().animate
        width: "-=260", 350
      $(".top-bar").stop().animate
        width: "-=260", 350
      $(".middle-bar").stop().animate
        width: "-=260", 350
      $(".bottom-bar").stop().animate
        width: "-=260", 350

  $("div.field input").keyup ->
    id = $(this).attr("id")
    value = $(this).val()
    $("span[data-bip-attribute = '" + id + "']:contains('" + value + "')").closest("tr").show()
    $("span[data-bip-attribute = '" + id + "']:not(:contains('" + value + "'))").closest("tr").hide()

  $("#show-columns").on "hide.bs.dropdown", (e) ->
    target = $(e.target)
    if target.hasClass("keepopen") or target.parents(".keepopen").length
      false # returning false should stop the dropdown from hiding.
    #else
      true

  $(".dropdown-menu input[type='checkbox']").click ->
    column = $(this).val()
    checked = this.checked

    if column == "All"
      $(".dropdown-menu input[type='checkbox']").prop "checked", true
    else
      if checked
        $td = $("span[data-bip-attribute = '" + column + "']").parent()
        $th = $td.closest('table').find('th').eq($td.index())

        $th.show()
        $td.show()

      else
        $td = $("span[data-bip-attribute = '" + column + "']").parent()
        $th = $td.closest('table').find('th').eq($td.index())

        $th.hide()
        $td.hide()
