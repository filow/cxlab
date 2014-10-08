require 'digest/sha2'
class Manage::Admin < ActiveRecord::Base
	# uid（登陆账号）不允许重复
	validates_uniqueness_of :uid
	# 提交表单时必须包含uid以及nickname
	validates_presence_of :uid
	validates_presence_of :nickname

	# 密码至少8位
	validates_length_of :pwd,minimum: 8,allow_blank:true,on: [:create,:update]

	# 邮箱格式验证
	validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: [:create,:update],allow_blank:true
	
	# 检查是否成功为password赋值
	validate :password_must_be_present



	has_and_belongs_to_many :roles
	attr_reader :pwd
	# pwd赋值方法，当使用user.pwd=的时候会触发这个方法
	def pwd=(new_pw)
		# 当新的密码非空时，设置数据库password字段为加密后的字符串
		unless new_pw.blank?
			@pwd=new_pw
			self.password=self.class.encrypt_password(self.uid,new_pw)
		end
	end

	def self.auth(uid,password)
		if user=find_by_uid(uid)
			if user.password == encrypt_password(user.uid,password)
				user
			end
		end
	end

	def self.encrypt_password(uid,pw)
		Digest::SHA2.hexdigest(uid+"_ADMIN_"+pw)
	end

	def roles_in_id=(id_array=nil)
		# 清空所有角色信息
		roles.clear

		# 如果id数组不为空，就遍历
		if id_array
			id_array.each do |role_id|
				# 找到对应的角色
				role = Manage::Role.find_by_id(role_id)
				# 如果角色不为空，就插入数据库
				roles << role if role
			end
		end

		# 返回角色信息
		roles
	end
private
	def password_must_be_present
		errors.add(:pwd,"没有找到") unless password.present?
	end
end
