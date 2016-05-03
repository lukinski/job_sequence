success_target = $('#sequence_result')
error_target = $('#sequence_error')

show_result = (sequence) ->
  success_target.show().html '<h5>' + sequence + '</h5>'
  return

show_error = (error) ->
  error_target.show().text 'Error: '+ error
  return

clear_results = ->
  success_target.hide().text ''
  error_target.hide().text ''
  return

$(document).ready ->
  clear_results()
  $('#job_form').on('ajax:success', (e, data, status, xhr) ->
    show_result data.sequence
    return
  ).on('ajax:error', (e, xhr, status, error) ->
    show_error xhr.responseJSON.error
    return
  ).on('ajax:beforeSend', (xhr, settings) ->
    clear_results()
    return
  )
  return
