class Cxpt::IndexController < CxptController
  def index
    
    @news_with_cover = Cxpt::Mnews.news_with_cover.limit(5).select(:id,:title,:cover)

    @sys_intro = Cxpt::Mnews.where(title: '实验室简介').first

    @tzgg = Cxpt::Cate.where(name:'通知公告').first.index_list.limit(8)
    @cxdt = Cxpt::Cate.where(name:'创新动态').first.index_list.limit(8)
    @jxjh = Cxpt::Cate.where(name:'教学计划').first.index_list.limit(8)

    @cxcg = Cxpt::Cate.where(name:'创新作品').first.newses.where(is_draft:false).select(:id,:title,:cover).limit(8)
  end
end
