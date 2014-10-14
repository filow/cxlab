class Manage::Node < ActiveRecord::Base
    validates_numericality_of :pid
    validates_presence_of :name
    validates_uniqueness_of :name,on: :create


    has_and_belongs_to_many :roles
    belongs_to :parent, class_name: "Manage::Node",foreign_key: "pid"

    def self.tree_view(child_val=nil)
        if child_val==nil
            child_nodes=where('pid != 0').all
        else
            child_nodes=child_val
        end
        parent_nodes=where(pid: 0).order(sort: :asc).all
        result=[]
        parent_nodes.each do |pnode|
            temp_node=pnode
            temp_node.child=child_nodes.find_all{|cnode| cnode.pid==temp_node.id}.sort_by{|x| x.sort}
            result<<temp_node
        end
        result
    end

    def child=(val)
        @child=val
    end
    def child
        @child
    end
end
