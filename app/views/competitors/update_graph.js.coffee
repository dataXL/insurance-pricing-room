## Bar Chart
$chrt_border_color = "#efefef";
$chrt_second = "#d3d3d3";

dBar = <%= raw @bars %>
insurers = <%= raw @insurers %>

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
