$(document).on 'ready page:load', ->
  $('.average-stars').raty
    path: '/assets/images/'
    score: ->
      $(this).attr 'data-score'
    readOnly: true
    half: true

  $('.rating-stars').raty
    path: '/assets/images/'
    score: ->
      $(this).attr 'data-score'
    click: (score, evt) ->
      query_string = $(this).attr('id')
      query_array = query_string.split('/')
      console.log query_array
      $.ajax
        url: $(this).attr('id')
        method: 'PATCH'
        data: rating:
          score: score
        async: true
        success: alert('Updated Successfully')
