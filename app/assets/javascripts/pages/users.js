(function () {
  var page_scripts = function () {
    if (!$("#users").length) return;

    // User list checkboxes
    var $allUsers = $(".select-users input:checkbox");
    var $checkboxes = $("[name='select-user']");

    $allUsers.change(function () {
      var checked = $allUsers.is(":checked");
      if (checked) {
        $checkboxes.prop("checked", "checked");
        toggleBulkActions(checked, $checkboxes.length);
      } else {
        $checkboxes.prop("checked", "");
        toggleBulkActions(checked, 0);
      }
    });

    $checkboxes.change(function () {
      var anyChecked = $(".user [name='select-user']:checked");
      toggleBulkActions(anyChecked.length, anyChecked.length);
    });

    function toggleBulkActions(shouldShow, checkedCount) {
      if (shouldShow) {
        $(".users-list .header").hide();
        $(".users-list .header.select-users").addClass("active").find(".total-checked").html("(" + checkedCount + " total users)");

      } else {
        $(".users-list .header").show();
        $(".users-list .header.select-users").removeClass("active");
      }
    }

    // alert( $(".row.user").length );
    // alert ( $(" .links a").length );

    var $links = $(" .links a");

    $links.click(function (e) {
      e.preventDefault();

      // Remove div stating that no records were found
      $('#no-records').remove();

      //Uncheck all records
      $checkboxes.prop("checked", "");
      toggleBulkActions(false, $checkboxes.length);
      $allUsers.prop('checked', false);

      $links.removeClass("active");
      var str = $(this).text();

      var no_records = "<div id='no-records' class='row user' style='text-align: center !important; background: #FAFAFC !important'>"
                        + "<span>No matching records were found</span>"
                        + "</div>";

      if (str.match("^Active")) { // List only active users
          $('.row.user').has(".label.label-success").show();
          $('.row.user').has(".label.label-warning").hide();

          if($('.row.user').has(".label.label-success").length == 0)
            $( no_records ).insertBefore( ".row.pager-wrapper" );

      } else if (str.match("^Pending")) { // List only users who didn't activate their accounts yet

          $('.row.user').has(".label.label-warning").show();
          $('.row.user').has(".label.label-success").hide();

          if($('.row.user').has(".label.label-warning").length == 0)
            $( no_records ).insertBefore( ".row.pager-wrapper" );

      } else { // List all users
          $('.row.user').has(".label.label-success").show();
          $('.row.user').has(".label.label-warning").show();
      }

      $checkboxes = $("[name='select-user']:visible");
      $(this).addClass("active");
    });

    // Focus first input when form modal is shown
    $('#form-validation-modal').on('shown.bs.modal', function (e) {
      $("#form-validation-modal").find("input:text:eq(0)").focus();
    })

    // Form validation
    $('#new-user-form').validate({
      rules: {
        "user[name]": {
          required: true
        },
        "user[email]": {
          required: true,
          email: true
        },
        "user[notes]": {
          required: true
        }
      },
      highlight: function (element) {
        $(element).closest('.form-group').removeClass('success').addClass('error');
      },
      success: function (element) {
        element.addClass('valid').closest('.form-group').removeClass('error').addClass('success');
      }
    });
  };

  $(document).on("ready page:load", page_scripts);

})();
