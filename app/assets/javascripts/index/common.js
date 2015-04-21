//= require jquery
//= require jquery_ujs
//= require bootstrap/tooltip
//= require bootstrap/popover
//= require ejs
//= require underscore
// 关闭登录框
var close_login_box= function (){
    $('#black-layer').fadeOut();
    $('#login-pop').fadeOut();
};

// 产生一个随机字符串
String.rand = function (length,symbols){
    symbols = symbols || 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    length = length || 5;
    var sym_arr = symbols.split('');
    var result = '';
    for(var i=0;i<length;i++){
        var r = sym_arr[parseInt(Math.random()*sym_arr.length)];
        result += r;
    }
    return result;
}
// 点击黑色区域直接关闭登陆框
$('#black-layer').click(close_login_box);
