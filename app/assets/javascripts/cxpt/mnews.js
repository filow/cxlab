//= require bootstrap_select

var $ = jQuery.noConflict();
$(document).on( "click", "div.summary_box", function() {
    $(this).removeClass("summary_box");
});


$('#cxpt_mnews_publish_at').change(function (){
    var time = Date.parse(this.value);
    time -= 8*3600*1000;
    var d = (time-Date.now())/1000;
    var result = "";
    if(d<=0){
        result="立即发布";
    }else{
        // 输出  于12月01日 11:11 发布
        result = "于"+this.value.slice(5,16).replace(/-/,"月").replace(/T/,"日 ")+"发布";
    }
    publish_button.value = result;
});

$('.selectpicker').selectpicker({
    style: 'btn-default'
});

var change_passage_submit_text = function(){
    var selector = $('#new_passage_select');
    var id = selector.val();
    var object = selector.find('option[value='+id+']');
    var type = object.data('subtext');
    var subitem = object.html();
    var button_text = '';
    var icon_plus = '<i class="glyphicon glyphicon-plus"></i>';
    var icon_edit = '<i class="glyphicon glyphicon-pencil"></i>';
    switch(type){
        case '文章页':
            button_text = icon_edit + ' 编辑 ' + subitem + ' 栏目';
            break;
        default:
            button_text = icon_plus + ' 为 ' + subitem + ' 栏目添加 ' + type;
    }
    $('#new_passage_submit').html(button_text);
};
$('#new_passage_select').change(change_passage_submit_text);
change_passage_submit_text();