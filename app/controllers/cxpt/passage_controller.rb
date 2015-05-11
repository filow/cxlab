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
    @passages = @cate.newses.select(:id,:title,:summary,:cover,:publish_at,:cxpt_cate_id).page(params[:page])

    render :index_image if @cate.display == 'image'
    render :index_gallery if @cate.display == 'gallery'
  end

  def show
    @passage = Cxpt::Mnews.find(params[:id])
    @passage.increment!(:view_count)
    @cate = @passage.cate
    @ancestor = @cate.parent
  end
end
