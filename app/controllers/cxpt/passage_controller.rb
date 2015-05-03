class Cxpt::PassageController < CxptController
  def index
  end

  def show
    @passage = Cxpt::Mnews.find(params[:id])
  end
end
