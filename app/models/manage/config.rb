class Manage::Config < ActiveRecord::Base
    belongs_to :config_type
    validates_inclusion_of :field_type,in: %w(text textarea rich_text datetime_picker email url number array select multiple_select),allow_nil:true,allow_empty:true
    
    def self.field_reflection
        {
            text: "text_field",
            textarea: "text_area",
            rich_text: "text_area",  # 之后改成富文本编辑器
            datetime_picker: "datetime_field",
            email: "email_field",
            url: "url_field",
            select: "text_field",  # 之后改成下拉菜单
            multiple_select: "text_field",  # 之后改成多选
            number: "number_field",
            array: "text_field", # 后续再改
        }
    end
end
