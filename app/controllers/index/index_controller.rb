class Index::IndexController < IndexController
  def index
    @news = News.published.limit(10)
    @heaer_home = true

    @contests = Contest.holdings
  end
end
