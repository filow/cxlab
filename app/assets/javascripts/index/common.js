//= require jquery
//= require jquery_ujs
// 关闭登录框
var close_login_box= function (){
    $('#black-layer').fadeOut();
    $('#login-pop').fadeOut();
};
// 点击黑色区域直接关闭登陆框
$('#black-layer').click(close_login_box);