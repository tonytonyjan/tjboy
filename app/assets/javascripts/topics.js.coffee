$(document).on 'page:change', () ->
  timeoutID = undefined;
  $('#check').keyup (e) ->
    clearTimeout timeoutID
    timeoutID = setTimeout () ->
      pattern = $('#topic_pattern').val()
      request = $('#check').val()
      $.ajax
        url: '/topics/check'
        data:
          pattern: pattern
          request: request
      .done (result) ->
        target = $('#check_status > glyphicon')
        rm = if result then 'remove' else 'ok'
        add = if result then 'ok' else 'remove'
        $('#check_status > .glyphicon').removeClass('glyphicon-' + rm).addClass('glyphicon-' + add)
    , 500