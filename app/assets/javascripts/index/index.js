'use strict';
$(document).ready(function(){

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

    (function (){
        var loaded_news_details = [];
        $('#news .news-list ul').delegate('li','mouseover',function(e){
            var elem = $(e.toElement);
            var title = elem.attr('title');
            if(title === undefined){return false;}
            // 如果新闻还未加载的话
            if(!loaded_news_details[title]){
                loaded_news_details[title] = {};

                // 生成随机id，在内容加载完之后更新dom
                var placeholder_id = loaded_news_details[title]['holder_id'];
                if(!placeholder_id){
                    placeholder_id = 'news_placeholder_' + String.rand();
                    loaded_news_details[title]['holder_id'] = placeholder_id;
                }

                elem.popover({
                    trigger: 'hover',
                    placement: 'left',
                    animation: false,
                    template: '<div class="popover" role="tooltip">' +
                            '<div class="arrow"></div>' +
                            '<h3 class="popover-title"></h3>' +
                            '<div class="popover-content" id="'+ placeholder_id +'"></div>' +
                            '</div>',
                    content: function(){
                        if(!loaded_news_details[title]['content']){
                            loaded_news_details[title]['content'] = '正在加载中';
                            var content_url = elem.attr('href') + '/summary';
                            $.get(content_url).then(function(data){
                                $('#'+loaded_news_details[title]['holder_id']).text(data.content);
                                loaded_news_details[title]['content'] = data.content;
                            });
                        }
                        return loaded_news_details[title]['content'];
                    }
                });
            }
            elem.popover('show');
            //console.log(e);
            //
            //console.log(e) ;

        });
    })();

});