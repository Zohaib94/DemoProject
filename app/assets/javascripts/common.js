$(document).on('ready page:load', function(){
  $('.poster_show').load(function(){
    $(this).data('height', this.height);}).bind('mouseenter mouseleave', function(e) {
      $(this).stop().animate({
        height: $(this).data('height') * (e.type === 'mouseenter' ? 1.5 : 1)
      });
    });

    $('.search-field').keypress(function (e) {
    if (e.charCode != 0) {
      var regex = new RegExp("^[a-zA-Z0-9\\-\\s]+$");
      var key = String.fromCharCode(!e.charCode ? e.which : e.charCode);
      if (!regex.test(key)) {
        e.preventDefault();
        return false;
      }
    }
  });
});
