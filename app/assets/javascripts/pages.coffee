$(document).on 'page:change', ->
 $('.carousel-inner img').click (e) ->
   $('#image-modal img').attr 'src', $(this).attr('src')
   $('#image-modal').modal('show');
