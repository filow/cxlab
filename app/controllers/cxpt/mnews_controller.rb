class Cxpt::MnewsController < ManageController
  before_action :set_cxpt_mnews, only: [:show, :edit, :update, :destroy]

  # GET /cxpt/mnews
  # GET /cxpt/mnews.json
  def index
    @cxpt_mnews = Cxpt::Mnews.select('left(summary, 300) as summary').select(:id,:title, :author, :publish_at, :view_count,:cxpt_cate_id,:is_draft).all
    @cate = Cxpt::Cate.all_cates
    @cate_tree = Cxpt::Cate.tree_view
  end

  # GET /cxpt/mnews/1
  # GET /cxpt/mnews/1.json
  def show
    p @cxpt_mnews.cate
  end

  # GET /cxpt/mnews/new
  def new
    @cate = Cxpt::Cate.get_by_id(params[:cate])
    set_view_stats

    # 如果是文章页应当直接跳转到文章的对应页面
    if @cate.display == 'passage'
      # 首先寻找是否已经存在标题为cate.name的文章
      passage = @cate.newses.where('title = ?',@cate.name).select(:id).first
      # 如果不存在就新建一个
      passage ||= Cxpt::Mnews.init_passage_news(@cate)
      # 如果最后创建成功了
      if passage
        logger.info passage.to_json
        redirect_to edit_cxpt_mnews_url(passage.id)
      else
        redirect_to :index, flash: '初始化文章失败！'
      end
    else
      @cxpt_mnews = Cxpt::Mnews.new(publish_at: Time.now, cxpt_cate_id: @cate.id)
    end
  end

  # GET /cxpt/mnews/1/edit
  def edit
    @cate = @cxpt_mnews.cate
    set_view_stats

  end

  # POST /cxpt/mnews
  # POST /cxpt/mnews.json
  def create
    @cate = Cxpt::Cate.get_by_id(params[:cxpt_cate_id])
    @cxpt_mnews = Cxpt::Mnews.new(cxpt_mnews_params)
    set_view_stats
    respond_to do |format|
      if @cxpt_mnews.save
        format.html { redirect_to @cxpt_mnews, notice: '文章添加成功.' }
        format.json { render :show, status: :created, location: @cxpt_mnews }
      else
        format.html { render :new }
        format.json { render json: @cxpt_mnews.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cxpt/mnews/1
  # PATCH/PUT /cxpt/mnews/1.json
  def update
    @cate = @cxpt_mnews.cate
    set_view_stats
    respond_to do |format|
      if @cxpt_mnews.update(cxpt_mnews_params)
        format.html { redirect_to @cxpt_mnews, notice: '信息已更新' }
        format.json { render :show, status: :ok, location: @cxpt_mnews }
      else
        format.html { render :edit }
        format.json { render json: @cxpt_mnews.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cxpt/mnews/1
  # DELETE /cxpt/mnews/1.json
  def destroy
    @cxpt_mnews.destroy
    respond_to do |format|
      format.html { redirect_to cxpt_mnews_index_url, notice: '删除成功' }
      format.json { head :no_content }
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cxpt_mnews
      @cxpt_mnews = Cxpt::Mnews.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cxpt_mnews_params
      param=params.require(:cxpt_mnews).permit(:title, :author, :content, :is_draft, :publish_at,:cxpt_cate_id, :cover)
      if params[:commit] == "存为草稿"
        param[:is_draft] = true
      else
        param[:is_draft] = false
      end
      param
    end
  def set_view_stats
    stats = {title: true, content: 'full', author: false, publish_at: true, is_draft: false, image_uploader: false}
    display = @cate.display
    if display == 'passage'
      stats.merge!({title: false, publish_at: false})
    elsif display == 'gallery'
      stats.merge!({content: 'mini', publish_at: false, image_uploader: true})
    elsif display == 'image'
      stats.merge!({author: true, is_draft: true, image_uploader: true})
    else
      stats.merge!({author: true, is_draft: true})
    end
    @dopt = stats 
  end
end
