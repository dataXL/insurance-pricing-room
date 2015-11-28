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
