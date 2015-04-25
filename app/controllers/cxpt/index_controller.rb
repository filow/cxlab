class Cxpt::IndexController < CxptController
  def index
    @nav = YAML.load(File.read("config/exts/cxpt_nav.yml"))
  end
end
