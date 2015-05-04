class Cxpt::PassageController < CxptController
  def index
    @cate = Cxpt::Cate.where(name: params[:id]).first
    if @cate.display == 'passage'
      @p = @cate.newses.first
      redirect_to cxpt_pshow_url(@p) if @p
    end
    if @cate.pid == 0
      child = @cate.children.first
      redirect_to cxpt_pcate_url(child.name)
    end
    @ancestor = @cate.parent
    @passages = @cate.newses
  end

  def show
    @passage = Cxpt::Mnews.find(params[:id])
    @cate = @passage.cate
    @ancestor = @cate.parent
  end
end
