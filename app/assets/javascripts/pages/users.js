(function () {
  var page_scripts = function () {
    if (!$("#users").length) return;

    // alert("Hello, World!");

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
