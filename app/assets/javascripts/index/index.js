$(document).ready(function(){

    //视频背景高度自适应
    function bgheight(){
        var height = $(window).height();
        var vheight = $('video').height();
        var bgheight = height > vheight ? vheight : height;
        $(".bgvideo").height(bgheight);
    }
    bgheight();
    $(window).resize(function(data){
        bgheight();
    });

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