# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $("#product_template_form").on "keyup keypress", (e) ->
    code = e.keyCode or e.which
    if code is 13
      e.preventDefault()
      false

  $("a#reset").click ->
    $last = $("div[type='group']:last")

    #$(".form-group.form-actions").before($form);
    $last.remove()  if $("div[type='group']").length > 2

  $("a#add").click ->
    clone = $("div[type='group']:last").clone()
    current = $("div[type='group']").length
    clone.find("input[data-type='property']").attr "name", "properties[" + current + "][name]"
    clone.find("input[data-type='property']").val ""
    clone.find("select[data-type='type']").attr "name", "properties[" + current + "][type]"
    clone.find("select[data-type='type']").val "[]"
    lastDiv = clone.find("div.form-group:last")
    lastDiv.children().remove()
    html = "<input type='text' name='properties[" + current + "][values]' id='properties_0_values' class='form-control' " + "placeholder='Add value' data-type='values' style='display: none;'>"
    lastDiv.append html
    $(".form-group.form-actions").before clone
    $("input[data-type='values']:last").tagsinput()


$(document).on "change", "select", ->
  current = $(this).closest("div[type='group']").index() - 2
  html = "<input type='text' name='properties[" + current + "][values]' id='properties_0_values' class='form-control' " + "placeholder='Add value' data-type='values' style='display: none;'>"
  optionSelected = $("option:selected", this)
  valueSelected = @value
  if valueSelected is "Categorical"
    $(this).parent().next().append html
    $(this).parent().next().find("input").tagsinput()
  else
    $(this).parent().next().children().remove()
