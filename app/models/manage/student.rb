# require "#{Rails.root}/app/uploaders/avatar_uploader.rb"
class Manage::Student < ActiveRecord::Base
    # stuid（学号）不允许重复
    validates_uniqueness_of :stuid
    # 提交表单时必须包含uid以及nickname
    validates_presence_of :stuid
    validates_presence_of :name

    # 密码至少8位
    validates_length_of :pwd,minimum: 8,allow_blank:true,on: [:create,:update]

    # 邮箱格式验证
    validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: [:create,:update],allow_blank:true
    
    # 检查是否成功为password赋值
    validate :password_must_be_present

    # 学院/专业
    belongs_to :profession

    # 用户头像
    mount_uploader :avatar, AvatarUploader


    attr_reader :pwd
    # pwd赋值方法，当使用user.pwd=的时候会触发这个方法
    def pwd=(new_pw)
        # 当新的密码非空时，设置数据库password字段为加密后的字符串
        unless new_pw.blank?
            @pwd=new_pw
            self.password=self.class.encrypt_password(self.stuid,new_pw)
        end
    end

    def self.auth(stuid,password)
        if user=find_by_stuid(stuid)
            if user.password == encrypt_password(user.stuid,password)
                user
            end
        end
    end

    def self.encrypt_password(stuid,pw)
        Digest::SHA2.hexdigest(stuid+"_ADMIN_"+pw)
    end



    
private
    def password_must_be_present
        errors.add(:pwd,"没有找到") unless password.present?
    end
end
