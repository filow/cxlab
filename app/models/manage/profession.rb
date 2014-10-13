class Manage::Profession < ActiveRecord::Base
    has_many :students

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
end
