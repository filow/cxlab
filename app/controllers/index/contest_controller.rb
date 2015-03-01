class Index::ContestController < ApplicationController
  def index
    @contests = Contest.where(is_deleted: false).order(updated_at: :desc).all
  end
end
