# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  return  unless $("#coefficients").length

  $table = $("#coefficients-datatable")
  $table.dataTable
    paging: "full_numbers"
    iDisplayLength: 20
    aLengthMenu: [ [ 20, 50, 100, -1 ], [ 20, 50, 100, "All" ] ]
    bDestroy: true

  $("#coefficients-datatable_filter").detach().appendTo ".top-bar"
  $("#coefficients-datatable_paginate").detach().appendTo ".bottom-bar"

  jQuery(".best_in_place").best_in_place()

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
