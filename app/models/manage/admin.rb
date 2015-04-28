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

    # 一个管理员可以建立多个竞赛
    has_many :contests
    has_many :competes
    has_many :news


	attr_reader :pwd

	# pwd赋值方法，当使用user.pwd=的时候会触发这个方法
	def pwd=(new_pw)
		# 当新的密码非空时，设置数据库password字段为加密后的字符串
		unless new_pw.blank?
			@pwd=new_pw
			self.password=self.class.encrypt_password(self.uid,new_pw)
		end
	end

	# 验证账户名及密码
	def self.auth(uid,password)
		if user=find_by_uid(uid)
			if user.password == encrypt_password(user.uid,password)
				user
			end
		end
	end

	# 加密辅助函数
	def self.encrypt_password(uid,pw)
		Digest::SHA2.hexdigest(uid+"_ADMIN_"+pw)
	end

	#修改管理员的用户角色
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

	# 返回以树形（2层）形式表示的权限列表信息
	def tree_view_of_nodes
        Manage::Node.tree_view(child_nodes)
	end

	# 返回用户所拥有权限的节点数据（原始数据）
	def child_nodes
		Manage::Node.joins(:roles).where("roles.id"=>self.role_ids,"roles.is_enabled"=>true).uniq
	end

	# 查看用户是否拥有指定的权限
	def can_access?(privilege_name)
		# 初始化权限缓存
		init_cache
		# 取得权限信息
		nodes = @privileges_cache[self.id]

		# 如果nodes==nil,就再次设定一下
		nodes ||= set_admin_privileges

		# 检测权限
		nodes.include?(privilege_name.to_s)
	end

	# 清空用户权限信息（主要用于更新权限操作）
	def clear_privileges_cache
		# 初始化权限缓存
		init_cache
		# 删除缓存
		@privileges_cache.delete(self.id)
	end

	# 当用户拥有权限时的操作
	def with_access(privilege_name)
		if block_given? && can_access?(privilege_name)
			yield
		end
	end

	# 当用户没有权限时的操作
	def without_access(privilege_name)
		if block_given? && !can_access?(privilege_name)
			yield
		end
	end

private
	def password_must_be_present
		errors.add(:pwd,"没有找到") unless password.present?
	end

	# 将用户的权限信息存入缓存
	def set_admin_privileges
		nodes = child_nodes()
		# 首先去除pid为0的节点，随后将所有节点的name值取出合并为数组
		node_names = nodes.reject{|node| node.pid==0}.collect{|node| node.name}

		# 初始化权限缓存
		init_cache

		# 保存权限信息
		@privileges_cache[self.id] = node_names

		# 返回权限信息
		node_names
	end

	def init_cache
	# 初始化权限缓存
		@privileges_cache ||= Cache.new("ManageAdminPrivileges")
	end
end
