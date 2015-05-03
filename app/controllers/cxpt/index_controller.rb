class Cxpt::IndexController < CxptController
  def index
    @nav = YAML.load(File.read("config/exts/cxpt_nav.yml"))
    @news_with_cover = Cxpt::Mnews.news_with_cover.limit(5).select(:id,:title,:cover)
  end
end
