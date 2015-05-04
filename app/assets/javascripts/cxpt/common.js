//= require jquery


$(document).ready(function(){
    'use strict';
    $('.nav .parent').mouseenter(function(){
        var p = $(this).parent('li');
        p.find('.child').slideDown(200);
        p.mouseleave(function(){
            p.find('.child').slideUp(200);
        });
    });
});