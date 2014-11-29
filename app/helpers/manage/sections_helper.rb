module Manage::SectionsHelper
    def section_form_for(obj,compete,&block)
        if obj.new_record?
            form_for(obj,{url: manage_compete_sections_path(compete)},&block)
        else
            form_for(obj,{url:manage_compete_section_path(compete, obj),html: {method: "patch"}},&block)
        end
    end
end
