class Manage::Section < ActiveRecord::Base
    belongs_to :compete


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


end
