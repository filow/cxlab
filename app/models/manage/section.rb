class Manage::Section < ActiveRecord::Base
    validates_presence_of :name
    # 阶段名称在所在的比赛中不能重复
    validate :name_must_be_unique_in_one_compete
    # 阶段开始时间必须小于比赛的开始时间，结束时间必须早于比赛的结束时间
    validate :end_time_should_earlier_than_its_parent

    belongs_to :compete
    has_many :xforms


private

    def name_must_be_unique_in_one_compete
        if !name.blank?
            if id.nil?
                c = Manage::Section.where(name: name).count()
            else
                c = Manage::Section.where(name: name).where("id != ?",id).count
            end

            if c >= 1
                errors.add(:name,"已经存在，请再取一个")
            end
        end
    end

    def end_time_should_earlier_than_its_parent
        parent = compete
        if end_time.to_date > parent.end_time
            errors.add(:end_time,"不能比比赛的结束时间 [#{parent.end_time}] 更晚")
        end
    end
end
