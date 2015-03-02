//= require jquery
//= require jquery_ujs
// 关闭登录框
var close_login_box= function (){
    $('#black-layer').fadeOut();
    $('#login-pop').fadeOut();
};
// 登录按钮点击事件
$('#login-btn').click(function(){
    $('#black-layer').fadeIn();
    $('#login-pop').fadeIn();
    return false;
});
// 点击黑色区域直接关闭登陆框
$('#black-layer').click(close_login_box);