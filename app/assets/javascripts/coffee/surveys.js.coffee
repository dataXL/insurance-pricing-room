# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  return  unless $("#surveys").length

  ## Bar Chart
  $chrt_border_color = "#efefef";
  $chrt_second = "#d3d3d3";

  options =
    yaxes:
      min: 0

    xaxis:
      min: -0.5
      max: gon.surveys.length - 0.5
      mode: "categories"
      ticks: gon.surveys

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

  plot = $.plot($("#bar-chart"), [gon.survey_bars], options)

  $("#bar-chart").bind "plothover", (event, pos, item) ->
    if item
      $("#bar-chart").css "cursor", "pointer", "important"
    else
      $("#bar-chart").css "cursor", "default", "important"

  $table = $("#surveys-datatable")
  $table.dataTable
    fixedHeader: true
    paging: "full_numbers"
    iDisplayLength: 9
    aLengthMenu: [ [ 20, 50, 100, -1 ], [ 20, 50, 100, "All" ] ]
    bDestroy: true

  $("#surveys-datatable_filter").detach().appendTo ".top-bar"
  $("#surveys-datatable_paginate").detach().appendTo ".bottom-bar"

  jQuery(".best_in_place").best_in_place()
