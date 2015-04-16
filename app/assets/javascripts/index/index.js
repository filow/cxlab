
$(document).ready(function(){

    $('[data-typer-targets]').typer();
        
    $(".competition-list > .flexslider").flexslider({
        animation: "slide",
        animationSpeed: 1e3,
        animationLoop: !1,
        slideshow: !1,
        manualControls: ".competition-list .tab-control  li",
        sync: ".more-course .flexslider",
        prevText: "",
        nextText: "",
        init: function() {
            $(".competition-list .flexslider .container").append($(".competition-list .flex-viewport"));
        },
    });

});