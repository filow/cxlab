//= require bootstrap
(function() {
  $('#carousel').on('slide.bs.carousel', function(prop) {
    var id;
    id = $(prop.relatedTarget).attr("data-id");
    $('#news-list-ul li').removeClass("active");
    return $("#news-list-ul li[data-id=" + id + "]").addClass("active");
  });

  $('#news-list-ul li').click(function() {
    var id;
    id = $(this).attr("data-id");
    $('#carousel').carousel(parseInt(id));
    $('#news-list-ul li').removeClass("active");
    return $(this).addClass("active");
  });
}).call(this);
