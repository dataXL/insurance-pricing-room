# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  return  unless $("#dashboard").length

  $(".ex1").slider formatter: (value) ->
    "Current value: " + value

  $(document).on "click", "#previous", ->
    tariffID = parseInt($("tr.selected").find("a:first").text()) - 1

    $.ajax({
     type: "POST",
     url: "home/update_graph",
     data: {
       ctariff: tariffID
     },
     dataType: "script"
    });

  $(document).on "click", "#next", ->
    tariffID = parseInt($("tr.selected").find("a:first").text()) + 1

    $.ajax({
     type: "POST",
     url: "home/update_graph",
     data: {
       ctariff: tariffID
     },
     dataType: "script"
    });


  $(document).on "click", "tr", ->
    $("tr.selected").removeClass("selected")

    tariffID = $(this).find("a:first").text()
    $("tr > td.sorting_1:contains('" + tariffID + "')").parent().addClass("selected")

    #$.ajax({
    # type: "POST",
    # url: "competitors/update_graph",
    # data: {
    #   tariff_id: tariffID
    # },
    # dataType: "script"
    #});

  $table = $("#products-datatable")
  $table.dataTable
    paging: "full_numbers"
    iDisplayLength: 20
    aLengthMenu: [ [ 20, 50, 100, -1 ], [ 20, 50, 100, "All" ] ]
    bDestroy: true

  $("#products-datatable_length").detach()
  $("#products-datatable_filter").detach()
  $("#products-datatable_paginate").detach()
  $("#products-datatable_info").detach()

  $table = $("#tariffs-datatable")
  $table.dataTable
    paging: "full_numbers"
    iDisplayLength: 20
    aLengthMenu: [ [ 20, 50, 100, -1 ], [ 20, 50, 100, "All" ] ]
    bDestroy: true

  $("#tariffs-datatable_length").detach()
  $("#tariffs-datatable_filter").detach()
  $("#tariffs-datatable_paginate").detach()
  $("#tariffs-datatable_info").detach()

  $table = $("#scenarios-datatable")
  $table.dataTable
    aaSorting: []
    paging: "full_numbers"
    iDisplayLength: 20
    aLengthMenu: [ [ 20, 50, 100, -1 ], [ 20, 50, 100, "All" ] ]
    bDestroy: true

  $("#scenarios-datatable_length").detach()
  $("#scenarios-datatable_filter").detach()
  $("#scenarios-datatable_paginate").detach()
  $("#scenarios-datatable_info").detach()

  jQuery(".best_in_place").best_in_place()
