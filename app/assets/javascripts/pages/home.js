(function () {
	var page_scripts = function () {
		if (!$("#dashboard").length) return;

	    // Range Datepicker
      $('.input-daterange').datepicker({
      	autoclose: true,
      	orientation: 'right top',
      	endDate: new Date()
      });

      var d1 = [[0.6, 67512], [2.2, 61886], [31.8, 56260], [58.5, 50634], [58.5, 45008]];

      // Flot Charts
      var chart_border_color = "#efefef";
			var chart_color = "#b0b3e3";

			var d = [[utils.get_timestamp(15), 1290], [utils.get_timestamp(14), 1050], [utils.get_timestamp(13), 1100], [utils.get_timestamp(12), 1300], [utils.get_timestamp(11), 1050], [utils.get_timestamp(10), 1521], [utils.get_timestamp(9), 950], [utils.get_timestamp(8), 1130], [utils.get_timestamp(7), 1100], [utils.get_timestamp(6), 1472], [utils.get_timestamp(5), 1410], [utils.get_timestamp(4), 1684], [utils.get_timestamp(3), 1410], [utils.get_timestamp(2), 1322], [utils.get_timestamp(1), 1050], [utils.get_timestamp(0), 1238]];

			var d2 = [[utils.get_timestamp(14), 1500], [utils.get_timestamp(13), 1600], [utils.get_timestamp(12), 1630], [utils.get_timestamp(11), 1310], [utils.get_timestamp(10), 1530], [utils.get_timestamp(9), 2050], [utils.get_timestamp(8), 2310], [utils.get_timestamp(7), 2050], [utils.get_timestamp(6), 2125], [utils.get_timestamp(5), 1400], [utils.get_timestamp(4), 1600], [utils.get_timestamp(3), 1930], [utils.get_timestamp(2), 2000], [utils.get_timestamp(1), 2320]];

			var options = {
				xaxis : {
					mode : null,
					min: 1,
					max: 10
				},
				series : {
					lines : {
						show : true,
						lineWidth : 2,
						fill : true,
						fillColor : {
							colors : [{
								opacity : 0.04
							}, {
								opacity : 0.1
							}]
						}
					},
					shadowSize : 0
				},
				selection : {
					mode : "x"
				},
				grid : {
					hoverable : true,
					clickable : true,
					tickColor : chart_border_color,
					borderWidth : 0,
					borderColor : chart_border_color,
				},
				tooltip : true,
				colors : [chart_color]
			};

			var plot = $.plot($("#visitors-chart"), [d1]);

			/*var plot2 = $.plot($("#payments-chart"), [d2], $.extend(options, {
				tooltipOpts : {
					content : "Payments on <b>%x</b>: <span class='value'>$%y</span>",
					defaultTheme : false,
					shifts: {
						x: -75,
						y: -70
					}
				}
			}));

			var plot3 = $.plot($("#signups-chart"), [d], $.extend(options, {
				tooltipOpts : {
					content : "New signups on <b>%x</b>: <b class='value'>%y</b>",
					defaultTheme : false,
					shifts: {
						x: -78,
						y: -70
					}
				}
			}));*/
	};

	$(document).on("ready page:load", page_scripts);
})();
