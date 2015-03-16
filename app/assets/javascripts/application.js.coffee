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
    $('form.matrix').on 'change', 'select#matrix_number', ->
        number = $(@).val()
        send_url = $(@).data('change-dim-url')
        $.post send_url, dimension: number
        $('#sle-solution').html('')

    $(':file').filestyle
      input: false
