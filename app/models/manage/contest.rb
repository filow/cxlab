class Manage::Contest < ActiveRecord::Base
    # 管理员会建立竞赛
    belongs_to :admin
end
