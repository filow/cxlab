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


    $('.scroll').click(function(){
        $("html,body").animate({scrollTop:$(".section-one").offset().top - 40},700);
        $('header').addClass('header-fix').removeClass('header-home');
    });
    $(window).scroll(function(){
        scheight = $(window).scrollTop();
        var vheight = $(".section-one").offset().top - 50;
        if(scheight > vheight){
            $('header').addClass('header-fix').removeClass('header-home');
        }
        else{
            $('header').addClass('header-home').removeClass('header-fix');
        }    
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