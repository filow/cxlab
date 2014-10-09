module Manage::IndexHelper
    def task_color(str)
        case str
        when "正在进行"
            "success"
        when "需要改进"
            "warning"
        when "等待"
            "active"
        end
    end
end
