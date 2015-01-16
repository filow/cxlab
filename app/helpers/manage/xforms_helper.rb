module Manage::XformsHelper
    def xform_form_for(obj,compete,section,args={},&block)
        if obj.new_record?
            form_for(obj,{url: manage_compete_section_xforms_path(compete,section)}.merge(args),&block)
        else
            form_for(obj,{url:manage_compete_section_xforms_path(compete,section, obj),html: {method: "patch"}}.merge(args),&block)
        end
    end
end
