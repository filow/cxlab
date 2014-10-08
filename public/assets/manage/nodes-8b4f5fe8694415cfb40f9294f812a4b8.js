(function() {
  $(document).ready(function() {
    $('div.node-block span').hide();
    return $('div.node-block').mouseenter(function() {
      return $(this).find('span').show();
    }).mouseleave(function() {
      return $(this).find('span').hide();
    });
  });

}).call(this);
