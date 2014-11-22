class Xform < ActiveRecord::Base

    def self.field_types
        # %w(text_field datetime_local_field url_field number_field text_area kindeditor single_select multi_select confirm_box image_uploader file_uploader)
        %w(text_field datetime_local_field)
    end

end
