//= require jquery
//= require jquery.remotipart
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap-sprockets
//= require highcharts
//= require vis
//= require zeroclipboard
//= require bootstrap-filestyle
//= require turbolinks
//= require_tree .

window.pusher = new Pusher('e4bcbde5f21a3650ebd6', encrypted: true)

jQuery ->
  $('form.matrix').on 'change', 'select#matrix_number', ->
    number = $(@).val()
    send_url = $(@).data('change-dim-url')
    $.post send_url, dimension: number
    $('#sle-solution').html('')

  $(':file').filestyle
    input: false

	window.pusher.subscribe('test_channel').bind 'my_event', (data) ->
  	alert data.message
  	return