class Index::NewsController < ApplicationController
  def index
  end

  def show
  end

  def summary
    @news = News.select(:id,:pure_content,:contest_id).find(params[:id])
  end
end
