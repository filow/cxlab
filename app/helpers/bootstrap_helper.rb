module BootstrapHelper

    def bs_alert_box(message,type="info")
        content_tag :div,message,:class=>"alert alert-#{type}"
    end

    def bs_label_tag(message,type="info")
        content_tag :span,message,:class=>"label label-#{type}"
    end

    def bs_panel(args,&block)
        args[:style] ||= "default"
        base_str = "<div class=\"panel panel-#{args[:style]}\">"
        if args[:title]
            base_str += "<div class=\"panel-heading\">#{args[:title]}</div>"
        end
        base_str += "<div class=\"panel-body\">#{capture(&block)}</div>"
        if args[:footer]
            base_str += "<div class=\"panel-footer\">#{args[:footer]}</div>"
        end
        base_str += "</div>"
        raw(base_str)
    end
end
