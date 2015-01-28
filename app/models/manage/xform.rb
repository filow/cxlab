class Manage::Xform < ActiveRecord::Base
    validates_presence_of :name

    validate :common_validator
    before_save :param_handler

    belongs_to :section
    attr_accessor :value_range_from,:value_range_to
    def self.field_types
        # %w(text_field datetime_local_field url_field number_field text_area kindeditor single_select multi_select confirm_box image_uploader file_uploader)
        %w(text_field datetime_local_field)
    end

    def common_validator
        # 检测字段值
        method_name = "validator_#{field_type}".to_sym
        if self.class.private_method_defined?(method_name)
            send(method_name)
        end
    end

    def param_handler
        return nil if field_type.nil?
        # 如果字段不在字段类型中就抛出一个异常
        raise "字段#{field_type}不存在！" unless self.class.field_types.include?(field_type.to_s)

        # 处理字段类型
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

    def validator_text_field
        # 检查length_limit是否>=0
        if length_limit.to_i < 0 
            errors.add(:length_limit,"应当为一个正整数")
        end

        # 检查默认值
        if default_val[0]=="{"
            parsed_val = default_val.split(/[\{\}\.]/)[1..2]
            if parsed_val[0]=="stu"
                unless (%w(stuid name email phone profession grade)).include?(parsed_val[1])
                    errors.add(:default_val,'不是一个合法的表达式')
                end
            end
        end

    end

    def is_valid_datetime?(datetime_str)
        if default_val!="" 
            return default_val=~ /\d{4}-\d{2}-\d{2}T\d{2}:\d{2}/
        else
            return true
        end
    end
    def validator_datetime_local_field
        # 检查日期格式
        # 如果不为空且不符合格式，就添加一个错误
        errors.add(:default_val,"不是一个合法的日期格式") unless is_valid_datetime?(default_val)
        errors.add("起始时间","不是一个合法的日期格式") unless is_valid_datetime?(default_val)
        errors.add("结束时间","不是一个合法的日期格式") unless is_valid_datetime?(default_val)
        
    end
end
