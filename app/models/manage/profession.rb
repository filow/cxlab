class Manage::Profession < ActiveRecord::Base
    # name不允许重复
    validates_uniqueness_of :name
    # 提交表单时必须包含pid以及name
    validates_presence_of :name
    validates_presence_of :pid

    has_many :students
    before_destroy :ensure_profession_is_empty
    def self.tree_view
        parent_professions=where(pid: 0).all
        child_professions=where('pid != 0').all
        result=[]
        parent_professions.each do |pprofession|
            temp_profession=pprofession
            temp_profession.child=child_professions.find_all{|cprofession| cprofession.pid==temp_profession.id}
            result<<temp_profession
        end
        result
    end

    def child=(val)
        @child=val
    end
    def child
        @child
    end

    private
      #删除学院前保证专业为空
      def ensure_profession_is_empty
        if pid==0
          Manage::Profession.where(pid:id).empty?
        end
      end
end
