class Manage::Role < ActiveRecord::Base
    # name（角色名）不允许重复
	validates_uniqueness_of :name
	# 提交表单时必须包含name以及remark
	validates_presence_of :name
	validates_presence_of :remark

	has_and_belongs_to_many :admins
    has_and_belongs_to_many :nodes

    def nodes_in_id=(id_array=nil)
		# 清空所有节点信息
		nodes.clear

		# 如果id数组不为空，就遍历
		if id_array
			id_array.each do |node_id|
				# 找到对应的节点
				node = Manage::Node.find_by_id(node_id)
				# 如果节点不为空，就插入数据库
				nodes << node if node
			end
		end

		# 返回节点信息
		nodes
	end
end
