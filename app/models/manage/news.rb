class Manage::News < ActiveRecord::Base
    # 管理员发布资讯
    belongs_to :admin

    #获得所有比赛项目
   def self.all_contests
      [["系统公告", nil]]+Manage::Contest.select("name,id").collect{|r|[r.name,r.id]}
   end
   #找到对应的比赛项目
   def contest
      if contest_id
          contest_name=Manage::Contest.find(contest_id).name
      else
          contest_name="系统公告"
      end
          contest_name
    end
end
