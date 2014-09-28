$(document).ready(function(){

	//iframe 自适应	
	var iframe = $('#main_frame');
	var sidebar_width = $('.sidebar').width();
	var navbar_height = $('.navbar').height();
	var main_height = $(window).height();
	var main_width = $(window).width();
	var frame_height = main_height - navbar_height-5;
	var frame_width = $(document).width() - sidebar_width;
	iframe.height(frame_height);
	iframe.width(frame_width);
 
    //sidebar 滚动条初始化
    $(".sidebar-container").mCustomScrollbar({
        scrollInertia:150
    });

    //滚动条scroller dragger 显示处理
    $(".sidebar-container").hover(function () {
        $(".mCSB_dragger").fadeIn("fast");
    },function () {
        $(".mCSB_dragger").fadeOut("fast");
      });

    //折叠二级菜单
    var ToggleButton = $(".toggle-button");
    var SubNav = $(".sidebar-subnav");
    $(".sidebar-nav > li.sidebar-subnav-list > .sidebar-subnav-button").each(function (i) {
        $(this).click(function () {
            if ($(SubNav[i]).css("display") == "block") {
                $(SubNav[i]).slideUp(300);
                $(ToggleButton[i]).removeClass("fa fa-chevron-down").addClass("fa fa-chevron-left");

            } else {
                for (var j = 0; j < SubNav.length; j++) {
                    $(SubNav[j]).slideUp(300);
                    $(ToggleButton[j]).removeClass("fa fa-chevron-down").addClass("fa fa-chevron-left");
                }
                $(SubNav[i]).slideDown(300);
                $(ToggleButton[i]).removeClass("fa fa-chevron-left").addClass("fa fa-chevron-down");
            }
        });
    });

    // //Navbar dropdown
    // $(".navbar-nav > li > a").hover(function(){
    //     $(this).children(".navbar-dropdown").toggle();
    // },function () {
    //         $(this).children(".navbar-dropdown").toggle();
    //     });
    // });
});