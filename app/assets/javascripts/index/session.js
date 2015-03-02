var reg_checker = function (input){
    var content = input.val();
    var validator = input.data('validator');
    if(validator){
        var reg = new RegExp(validator);
        return reg.test(content);
    }else if(input.attr('id')=='pwd_confirmation'){
        return content == manage_student_pwd.value;
    }else{
        return true;
    }
    
}

var checkform = function(){
    $('.form-group input').each(function(){
        if(!reg_checker($(this))){
            alert($(this).data('message'));
            $(this).focus();
            return false;
        }
    });
    return true;
}
$('.form-group').focusout(function(){
    var input = $(this).find('input');
    $(this).find('i').remove();
    $(this).find('div.message').remove();
    if(reg_checker(input)){
        input.removeClass('invalid').addClass('valid');
        $(this).append('<i class="glyphicon glyphicon-ok"></i>');
    }else{
        input.removeClass('valid').addClass('invalid');
        $(this).append('<i class="glyphicon glyphicon-remove"></i>');
        $(this).append('<div class="message">'+input.data('message')+'</div>');
    }
});
