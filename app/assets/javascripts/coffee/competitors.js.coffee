# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  return  unless $("#competitors").length

  $chrt_border_color = "#efefef";
  $chrt_second = "#d3d3d3";

  data = [[0, 11],[1, 15]]
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

  plot = $.plot($("#bar-chart"), [data], options)

  $filters = $(".filters .filter input:checkbox")
  $filters.change ->
    $option = $(this).closest(".filter").find(".filter-option")
    if $(this).is(":checked")
      $option.slideDown 150, ->
        $option.find("input:text:eq(0)").focus()

    else
      $option.slideUp 150

  $table = $("#competitors-datatable")
  $table.dataTable
    paging: "full_numbers"
    iDisplayLength: 20
    aLengthMenu: [ [ 20, 50, 100, -1 ], [ 20, 50, 100, "All" ] ]
    bDestroy: true

  $("#competitors-datatable_filter").detach().appendTo ".top-bar"
  $("#competitors-datatable_paginate").detach().appendTo ".bottom-bar"


  jQuery(".best_in_place").best_in_place()
