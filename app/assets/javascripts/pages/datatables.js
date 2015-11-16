(function () {
  var page_scripts = function () {
    if (!$("#datatables").length) return;

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

    var $table = $("#orders-datatable");

    $table.dataTable({
        sPaginationType: "full_numbers",
        iDisplayLength: 20,
        aLengthMenu: [[20, 50, 100, -1], [20, 50, 100, "All"]],
        bDestroy: true
    });
  };

  $(document).on("ready page:load", page_scripts);
})();
