class Manage::Role < ActiveRecord::Base
    # name（角色名）不允许重复
	validates_uniqueness_of :name
	# 提交表单时必须包含name以及remark
	validates_presence_of :name
	validates_presence_of :remark

	has_and_belongs_to_many :admins
end
