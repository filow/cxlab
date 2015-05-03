class Cxpt::IndexController < CxptController
  def index
    
    @news_with_cover = Cxpt::Mnews.news_with_cover.limit(5).select(:id,:title,:cover)

    @sys_intro = Cxpt::Mnews.where(title: '实验室简介').first

    @tzgg = Cxpt::Cate.where(name:'通知公告').first.newses.select(:id,:title,:publish_at).limit(8)
  end
end
