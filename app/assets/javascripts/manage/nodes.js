$(document).ready(function (){
  $('div.node-block span').hide();
  $('div.node-block').mouseenter(function (){
    $(this).find('span').show();
  }).mouseleave(function (){
    $(this).find('span').hide();
  })
});
