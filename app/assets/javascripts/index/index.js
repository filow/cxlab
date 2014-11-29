$(document).ready(function(){

    //Header slide
    $(window).scroll(function() {
        var currenttop = $(window).scrollTop();
        // console.log(currenttop);
        var hideHeaderHeight = 318;
        var fixedHeaderHeight = 520;
        if(currenttop < hideHeaderHeight) {
            $("header").addClass("slideDown").removeClass("slideUp");
        } else {
            $("header").addClass("slideUp").removeClass("slideDown");
        }
        if(currenttop < fixedHeaderHeight){
            $(".competition-nav").removeClass("fixed-competition-nav");
        } else {
            $(".competition-nav").addClass("fixed-competition-nav");
        }

    });

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