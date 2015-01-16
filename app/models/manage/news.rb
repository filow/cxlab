class Manage::News < ActiveRecord::Base
  # 管理员发布资讯
  belongs_to :admin
  validates_length_of :title,minimum: 5
  validates_length_of :content,minimum: 20

  before_save :set_summary_and_pure_content
  
  def set_summary_and_pure_content
    self.pure_content=self.content.gsub(/<\/?.*?>/,"").gsub(/&\w+;/," ").gsub(/\s+/," ")
    self.summary=self.pure_content[0,255]
  end

    #获得所有比赛项目
   def self.all_contests
      [["系统公告", nil]]+Manage::Contest.select("name,id").collect{|r|[r.name,r.id]}
   end
   #找到对应的比赛项目
  def contest
    if contest_id
        contest_name=get_contest_obj().name
    else
        contest_name="系统公告"
    end
    contest_name
  end

  def contest_color
    if contest_id
      return 'info'
    else
      return 'warning'
    end
  end

  def self.published
    self.where('publish_at < ?',Time.now).where(is_draft: false,is_deleted: false).order(publish_at: :desc)
  end
private
  def get_contest_obj
    @cached_contest ||= Manage::Contest.find(contest_id)
    @cached_contest
  end
end
