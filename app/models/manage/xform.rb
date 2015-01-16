class Manage::Xform < ActiveRecord::Base
    validates_presence_of :name

    after_initialize :param_handler
    belongs_to :section
    attr_accessor :value_range_from,:value_range_to
    def self.field_types
        # %w(text_field datetime_local_field url_field number_field text_area kindeditor single_select multi_select confirm_box image_uploader file_uploader)
        %w(text_field datetime_local_field)
    end

    def param_handler
        return nil if field_type.nil?
        # 如果字段不在字段类型中就抛出一个异常
        raise "字段#{field_type}不存在！" unless self.class.field_types.include?(field_type.to_s)
        method_name = "param_handler_#{field_type}".to_sym
        if self.class.private_method_defined?(method_name)
            send(method_name)
        end
        
        
    end



private
    # 所有param_handler函数都是对该字段私有内容的处理
    def param_handler_text_field
        puts "===========------------========="
    end

    def param_handler_datetime_local_field
        value_range = {from: value_range_from, to: value_range_to}
        write_attribute(:value_range,value_range)
    end
end
