class CxptController < ApplicationController
  before_action :set_navs

  def set_navs
    @nav = YAML.load(File.read("config/exts/cxpt_nav.yml"))
    @hot_passages = Cxpt::Mnews.published.select(:id,:title,:view_count).order(view_count: :desc).limit(8)
  end

end