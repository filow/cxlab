class Index::IndexController < IndexController
  def index
    @news = News.published.limit(10)

    @contests = Contest.holdings
    @contests_data = Array.new
    @contests.each do |contest|
        @contests_data[contest.id] = Hash.new
        holdings = contest.holding_sections
        @contests_data[contest.id][:holdings] = holdings
        @contests_data[contest.id][:next_section] = contest.next_section_with_list(holdings)
        if holdings[0]
            @contests_data[contest.id][:compete] = holdings[0].compete
            @contests_data[contest.id][:percent] = 100.0 * holdings[0].compete.passed_days / holdings[0].compete.during_days
        end
    end

  end

end
