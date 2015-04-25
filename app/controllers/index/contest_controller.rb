class Index::ContestController < IndexController
  before_action :set_contests
  before_action :set_contest,only:[:detail, :confirm]
  def index

  end

  def detail
  end

  def confirm


  end

private
  def set_contests
    @contests = Contest.where(is_deleted: false).order(updated_at: :desc).all
  end

  def set_contest
    @contest = Contest.find(params[:id])
  end
end
