module ApplicationHelper

    def switch(condition,case1,case2)
        if condition
            case1
        else
            case2
        end
    end

    def form_errors(var)
        if var.errors.any?
            str=<<STR
<div class="alert alert-block alert-danger">
    <button type="button" class="close" data-dismiss="alert">&times;</button>
    <h4>您提交的表单有#{var.errors.count}个错误 </h4>
      <ul>
STR
            var.errors.full_messages.each do |message|
                str+="<li>#{message}</li>"
            end
            str+="</ul></div>"
            raw str
        end
    end

    def date_from_now(obj)
        timespan = Time.now.to_i - obj.to_i
        t = timespan.abs
        if t < 3600
            "#{t/60}分钟前"
        elsif t< 24*3600
            "#{t/3600}小时前"
        else
            obj.strftime("%Y-%m-%d")
        end
    end

end
