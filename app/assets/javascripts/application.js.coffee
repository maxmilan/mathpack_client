//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require highcharts
//= require highcharts/highcharts-more
//= require zeroclipboard
//= require_tree .

jQuery ->
    $('form.matrix').on 'change', 'select#matrix_number', ->
        number = $(@).val()
        send_url = $(@).data('change-dim-url')
        $.post send_url, dimension: number
        $('#sle-solution').html('')
