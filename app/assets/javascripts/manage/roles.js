$(document).ready(function(){
	var tr = $("#collapseadmin tr");
	tr.click(function () {
		$(this).children().first().children().each(function(){
			if(!this.checked)
				this.checked = true;
			else
				this.checked = false;
		});
		// var checkbox = $(this).children().first().children();
		// console.log(checkbox.checked);
	});
});