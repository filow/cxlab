class Index::ContestController < IndexController
  def index
    @contests = Contest.where(is_deleted: false).order(updated_at: :desc).all
  end
end
