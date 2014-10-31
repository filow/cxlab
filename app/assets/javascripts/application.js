// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
var data_name = $("#check_all").attr('data-name');
$("#check_all").click(function() {
	var checked = this.checked;
          	$("input[name='" + data_name + "']").each(function(){
  		this.checked = checked;
  	});
});
var $sub_checkbox = $("input[name='" + data_name + "']");
        	$sub_checkbox.click(function(){
            	$("#check_all").attr("checked",$sub_checkbox.length == $("input[name='" + data_name + "']:checked").length ? true : false);
});
