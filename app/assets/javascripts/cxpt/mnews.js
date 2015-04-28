

var jq = jQuery.noConflict();
jq(document).on( "click", "div.summary_box", function() {
    jq(this).removeClass("summary_box");
});


jq('#cxpt_mnews_publish_at').change(function (){
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