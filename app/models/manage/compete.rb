class Manage::Compete < ActiveRecord::Base
    belongs_to :contest
    belongs_to :admin

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
end
