class CxptController < ApplicationController
  before_action :set_navs

  def set_navs
    @nav = YAML.load(File.read("config/exts/cxpt_nav.yml"))
  end

end