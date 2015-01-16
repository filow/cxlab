class Manage::Section < ActiveRecord::Base
    validates_presence_of :name
    # 阶段名称在所在的比赛中不能重复
    validate :name_must_be_unique_in_one_compete
    # 阶段开始时间必须小于比赛的开始时间，结束时间必须早于比赛的结束时间
    validate :start_time_should_behind_its_parent
    validate :end_time_should_earlier_than_its_parent

    belongs_to :compete
    has_many :xforms


    def progress_bar_time
        the_compete = compete

        global_start_time = the_compete.start_time
        global_end_time = the_compete.end_time
        start_days = (start_time.to_date - global_start_time).to_i
        end_days = (global_end_time - end_time.to_date).to_i
        [start_days,during_days,end_days].collect{|x| x.to_f/the_compete.during_days*100}
    end

    def during_days
        (end_time.to_date - start_time.to_date).to_i
    end
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

    def start_time_should_behind_its_parent
        parent = compete
        if start_time.to_date < parent.start_time
            errors.add(:start_time,"不能比比赛的开始时间 [#{parent.start_time}] 更早")
        end
    end

    def end_time_should_earlier_than_its_parent
        parent = compete
        if end_time.to_date > parent.end_time
            errors.add(:end_time,"不能比比赛的结束时间 [#{parent.end_time}] 更晚")
        end
    end
end
