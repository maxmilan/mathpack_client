//= require jquery
//= require jquery.remotipart
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require highcharts
//= require zeroclipboard
//= require bootstrap-filestyle
//= require turbolinks
//= require_tree .

jQuery ->
  window.i18n = translations['ru']

  $('#sle_fields').on 'change', 'select', ->
    dimension = $(@).val()
    send_url = $(@).data('change-dim-url')
    sle_form = {}
    $formInputs = $('#sle_fields').find("input[id^='sle_form']")
    for input in $formInputs
      sle_form[input.name] = input.value
    $.post send_url, dimension: dimension, sle_form: sle_form

  $(':file').filestyle
    input: false
    buttonText: i18n.choose_file
