class Manage::Mail < ActiveRecord::Base
    #生成邮箱验证值
    def self.email_key()
      len=20
      chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
      newpass = ""
      1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
      Digest::SHA2.hexdigest(newpass+Time.now.to_s)
    end

    #验证邮箱,默认链接有效时间是一天
    def self.auth_email(sid,key,time=86400)
        #验证链接信息在数据库中
        if email=Manage::Mail.where(sid: sid , mail_key: key ).first
          #验证链接时间有效
          true if Time.now.to_i < email.created_at.to_i+time
        end
    end

end
