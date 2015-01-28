class Manage::Compete < ActiveRecord::Base
    belongs_to :contest
    belongs_to :admin
    has_many :sections
    
    def during_days
        (end_time-start_time).to_i
    end

    def passed_days
        (Date.today-start_time).to_i
    end

    def annual
        end_time.year
    end

    def name_with_annual
        "#{annual}年度#{contest.name if contest}比赛"
    end

    def self.holdings
        now = Date.today
        self.where('start_time<=? and end_time>=? and is_deleted=0',now,now).order(:start_time)
    end
end
