(function () {
    var page_scripts = function () {
    if (!$("#reports-alt").length) return;

		// daterange input
		$('input[name="daterange"]').daterangepicker({
			ranges: {
			 	'Today': [moment(), moment()],
			 	'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
			 	'Last 7 Days': [moment().subtract('days', 6), moment()],
			 	'This Month': [moment().startOf('month'), moment().endOf('month')],
			 	'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
			},
			opens: "left",
			startDate: moment().subtract('days', 29),
			endDate: moment()
		});


		// Datatable
    var $table = $("#datatable-example");

    $table.dataTable({
        "sPaginationType": "full_numbers",
        "iDisplayLength": 20,
	"aLengthMenu": [[20, 50, 100, -1], [20, 50, 100, "All"]],
	bDestroy: true
    });



		// bar chart
    var $chrt_border_color = "#efefef";
		var $chrt_second = "#607493";

		var dBar = gon.bars;
		//alert(dBar);
		var products = gon.products;

		var options = {
			yaxes: {
		        min: 0
		    },
			xaxis : {
				min: -0.5,
				mode: "categories",
				tickLength: 0,
				ticks: products,
			},
			series : {
				bars : {
					show : true,
					lineWidth: 0,
					barWidth: 0.55,
					align: 'center',
					fillColor : {
						colors : [{ opacity : 1 }, { opacity : 1 }]
					}
				},
				highlightColor: 'rgb(41,49,58)'
			},
			grid : {
				show: true,
				hoverable : true,
				clickable : true,
				tickColor : $chrt_border_color,
				borderWidth : 0,
				borderColor : $chrt_border_color,
			},
			tooltip : true,
			tooltipOpts : {
				content: function (a, b, c, d) {
					return "Product <b>" + b + "</b> got: <span class='value'>" + c+ " points </span>";
				},
				defaultTheme : false,
				shifts: {
					x: -65,
					y: -70
				}
			},
			colors : [$chrt_second],
		};

		$("#bar-chart").bind("plothover", function (event, pos, item) {
		    if (item) {
		        var tickClicked = item.series.xaxis.ticks[item.dataIndex].label;
		        $( "#datatable-example > tbody > tr").css( "background-color", "white" );
		        $( "#datatable-example > tbody > tr:has(td:contains('"+ tickClicked +"'))").css( "background-color", "#fff5c3" );
		    } else $( "#datatable-example > tbody > tr").css( "background-color", "white" );
		});

		var plot = $.plot($("#bar-chart"), [dBar], options);
	};

	$(document).on("ready page:load", page_scripts);
})();
