class Index::ContestController < ApplicationController
  def index
    @contests = Contest.order(updated_at: :desc).all
  end
end
