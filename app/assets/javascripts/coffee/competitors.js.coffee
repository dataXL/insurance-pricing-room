# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  return  unless $("#competitors").length

  $(document).on "click", "tr", ->
    $("tr.selected").removeClass("selected")

    tariffID = $(this).find("a:first").text()
    $("tr > td.sorting_1:contains('" + tariffID + "')").parent().addClass("selected")

    $.ajax({
     type: "POST",
     url: "competitors/update_graph",
     data: {
       tariff_id: tariffID
     },
     dataType: "script"
    });

  ## Bar Chart
  $chrt_border_color = "#efefef";
  $chrt_second = "#d3d3d3";

  dBar = gon.bars
  insurers = gon.insurers

  options =
    yaxes:
      min: 0

    xaxis:
      min: -0.5
      max: 1.5
      mode: "categories"
      ticks: insurers

    series:
      bars:
        show: true
        lineWidth: 0
        barWidth: 0.6
        align: "center"
        fillColor:
          colors: [
            opacity: 1
          ,
            opacity: 1
           ]

      highlightColor: "#a9a9a9"

    grid:
      show: true
      hoverable: true
      clickable: true
      tickColor: $chrt_border_color
      borderWidth: 0
      borderColor: $chrt_border_color

    colors: [ $chrt_second ]

  plot = $.plot($("#bar-chart"), [dBar], options)

  $("#bar-chart").bind "plothover", (event, pos, item) ->
      if item
        $("#bar-chart").css "cursor", "pointer", "important"
      else
        $("#bar-chart").css "cursor", "default", "important"

  $table = $("#competitors-datatable")
  $table.dataTable
    paging: "full_numbers"
    iDisplayLength: 20
    aLengthMenu: [ [ 20, 50, 100, -1 ], [ 20, 50, 100, "All" ] ]
    bDestroy: true

  $("#competitors-datatable_filter").detach().appendTo ".top-bar"
  $("#competitors-datatable_paginate").detach().appendTo ".bottom-bar"


  jQuery(".best_in_place").best_in_place()
