//= require jquery


$(document).ready(function(){
    'use strict';
    $('.nav .parent').mouseenter(function(){
        console.log('1');
        var p = $(this).parent('li');
        p.find('.child').show();
        p.mouseleave(function(){
            p.find('.child').hide();
        });
    });

});