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

    var $filters = $(".filters .filter input:checkbox");

    $filters.change(function () {
        var $option = $(this).closest(".filter").find(".filter-option");

        if ($(this).is(":checked")) {
            $option.slideDown(150, function () {
                $option.find("input:text:eq(0)").focus();
            });
        } else {
            $option.slideUp(150);
        }
    });

    // Filter dropdown options for Created date, show/hide datepicker or input text
    var $dropdown_switcher = $(".field-switch");
    $dropdown_switcher.change(function () {
        var field_class = $(this).find("option:selected").data("field");
        var $filter_option = $(this).closest(".filter-option");
        $filter_option.find(".field").hide();
        $filter_option.find(".field." + field_class).show();

        if (field_class === "calendar") {
            $filter_option.find(".datepicker").datepicker("show");
        } else {
            $filter_option.find(".field." + field_class + " input:text").focus();
        }
    });

    var $table = $("#tariff-detail-datatable");

    $table.dataTable({
        sPaginationType: "full_numbers",
        iDisplayLength: 20,
        aLengthMenu: [[20, 50, 100, -1], [20, 50, 100, "All"]],
        bDestroy: true
    });

    //$("#other-datatable_filter").detach().appendTo("#topbar");
    //$("#other-datatable_paginate").detach().appendTo("#bottombar");
  };

  $(document).on("ready page:load", page_scripts);
})();
