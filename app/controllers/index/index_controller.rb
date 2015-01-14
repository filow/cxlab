class Index::IndexController < IndexController
  def index
    @news = News.published.limit(10)
  end
end
