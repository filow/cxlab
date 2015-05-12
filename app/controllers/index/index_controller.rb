class Index::IndexController < IndexController
  def index
    @news = News.published.limit(10)

    @contests = Contest.holdings
    @contests_data = Array.new


  end

end
