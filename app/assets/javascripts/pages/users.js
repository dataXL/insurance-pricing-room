(function () {
  var page_scripts = function () {
    if (!$("#users").length) return;

    // Bulk actions
    $( "a#reset" ).click(function() {
      // TODO
    });

    $("a#delete").click(function() {
       var serializedArray = $("input:checked").serializeArray();
       var itemIdsArray = [];

       for (var i = 0, length = serializedArray.length; i < length; i++) {
          itemIdsArray.push(serializedArray[i]['value']);
       }

       $.ajax({
         type: "DELETE",
         url: "users/destroy_multiple",
         data: {
           users_ids: itemIdsArray
         },
         dataType: "script"
       });
    });

    // Search box
    $( "#search" ).on('input', function() {

      var noRecords = "<div id='no-records' class='row user' style='text-align: center !important; background: #FAFAFC !important'>"
                        + "<span>No matching records were found</span>"
                        + "</div>";

      $('#no-records').remove();
      $(".row.user:not(:contains('" + $(this).val() + "'))").hide();
      $(".row.user:contains('" + $(this).val() + "')").show();

      if($(".row.user:contains('" + $(this).val() + "')").length == 0)
        $( noRecords ).insertBefore( ".row.pager-wrapper" );
    });


    // Sort columns
    var $sortButton = $(".a [data-toggle='dropdown']");

    /*$( "a[data-toggle='dropdown']" ).bind( "click", function() {
      alert( "User clicked on 'foo.'" );
    });*/

    var $rows = $('.row.user');

    $( "ul.dropdown-menu > li" ).bind( "click", function() {
      switch($(this).text()) {
        case "Name":
          $rows.sort(function(a,b){
            var an = $(a).find("a[data-type='name']").text(),
              bn = $(b).find("a[data-type='name']").text();

            if(an > bn) {
              return 1;
            }
            if(an < bn) {
              return -1;
            }
            return 0;
          });

          $rows.detach().insertBefore( ".row.pager-wrapper" );
          break;
        case "Email":
          $rows.sort(function(a,b){
          var an = $(a).find("div[data-type='email']").text(),
            bn = $(b).find("div[data-type='email']").text();

            if(an > bn) {
              return 1;
            }
            if(an < bn) {
              return -1;
            }
            return 0;
          });

          $rows.detach().insertBefore( ".row.pager-wrapper" );
          break;
        case "Role":
          $rows.sort(function(a,b){
          var an = $(a).find("span[data-type='role']").text(),
            bn = $(b).find("span[data-type='role']").text();

            if(an > bn) {
              return 1;
            }
            if(an < bn) {
              return -1;
            }
            return 0;
          });

          $rows.detach().insertBefore( ".row.pager-wrapper" );
          break;
        case "Status":
          $rows.sort(function(a,b){
          var an = $(a).find("span[data-type='status']").text(),
            bn = $(b).find("span[data-type='status']").text();

            if(an > bn) {
              return 1;
            }
            if(an < bn) {
              return -1;
            }
            return 0;
          });

          $rows.detach().insertBefore( ".row.pager-wrapper" );
          break;
        case "Signed up":
          $rows.sort(function(a,b){
          var an = $(a).find("div[data-type='signed-up']").text(),
            bn = $(b).find("div[data-type='signed-up']").text();

            if(an > bn) {
              return 1;
            }
            if(an < bn) {
              return -1;
            }
            return 0;
          });

          $rows.detach().insertBefore( ".row.pager-wrapper" );
          break;
        default:
            break;
      }
    });

    // User list checkboxes
    var $allUsers = $(".select-users input:checkbox");
    var $checkboxes = $("[name^='delete']");

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
      var anyChecked = $(".user [name^='delete']:checked");
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

      var noRecords = "<div id='no-records' class='row user' style='text-align: center !important; background: #FAFAFC !important'>"
                        + "<span>No matching records were found</span>"
                        + "</div>";

      if (str.match("^Active")) { // List only active users
          $('.row.user').has(".label.label-success").show();
          $('.row.user').has(".label.label-warning").hide();

          if($('.row.user').has(".label.label-success").length == 0)
            $( noRecords ).insertBefore( ".row.pager-wrapper" );

      } else if (str.match("^Pending")) { // List only users who didn't activate their accounts yet

          $('.row.user').has(".label.label-warning").show();
          $('.row.user').has(".label.label-success").hide();

          if($('.row.user').has(".label.label-warning").length == 0)
            $( noRecords ).insertBefore( ".row.pager-wrapper" );

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
