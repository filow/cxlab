class Manage::NewsController < ManageController
  before_action :set_manage_news, only: [:show, :edit, :update, :destroy]
  before_action :set_mange_contests,only:[:index,:index_draft,:index_deleted]
  before_action :get_mange_contest_id,only:[:index,:index_draft,:index_deleted]
  # GET /manage/news
  # GET /manage/news.json
  # 显示已发布的资讯
  def index
      @news_cates = Manage::News.all_contests
  end

  def news_list
    @manage_news = Manage::News.order(id: :desc).select(:id,:title,:author,:summary,:is_draft,:is_deleted,:publish_at,:contest_id).all
    puts "111"
    puts @manage_news
  end

  # GET /manage/news/1
  # GET /manage/news/1.json
  def show
  end

  # GET /manage/news/new
  def new
    @manage_news = Manage::News.new
    @manage_news.publish_at = Time.now
    #发布者默认为管理员
    @manage_news.author=@admin.nickname
  end

  # GET /manage/news/1/edit
  def edit
  end

  # POST /manage/news
  # POST /manage/news.json
  def create
    @manage_news = Manage::News.new(manage_news_params)

    respond_to do |format|
      if @manage_news.save
        format.html { redirect_to manage_news_index_url, notice: '信息发布成功.' }
        format.json { render :show, status: :created, location: @manage_news }
      else
        format.html { render :new }
        format.json { render json: @manage_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manage/news/1
  # PATCH/PUT /manage/news/1.json
  def update
    respond_to do |format|
      if @manage_news.update(manage_news_params)
        format.html { redirect_to @manage_news, notice: '资讯更新成功.' }
        format.json { render :show, status: :ok, location: @manage_news }
      else
        format.html { render :edit }
        format.json { render json: @manage_news.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manage/news/1
  # DELETE /manage/news/1.json
  def destroy
    @manage_news.destroy
    respond_to do |format|
      format.html { redirect_to manage_news_index_deleted_url, notice: '资讯删除成功.' }
      format.json { head :no_content }
    end
  end

  #放入草稿箱
  def draft
    @manage_news = Manage::News.find(params[:news_id])
    @manage_news.is_deleted = false
    @manage_news.is_draft = true
    @manage_news.save
    respond_to do |format|
      format.html { redirect_to manage_news_index_draft_url, notice: "#{@manage_news.title}放入草稿箱." }
      format.json { head :no_content }
    end
  end
  #发布资讯
  def publish
    @manage_news = Manage::News.find(params[:news_id])
    @manage_news.is_deleted = false
    @manage_news.is_draft = false
    @manage_news.save
    respond_to do |format|
      format.html { redirect_to manage_news_index_url, notice: "#{@manage_news.title}发布成功." }
      format.json { head :no_content }
    end
  end
  #放入回收箱
  def recycle
    @manage_news = Manage::News.find(params[:news_id])
    @manage_news.is_deleted = true
    @manage_news.is_draft = false
    @manage_news.save
    respond_to do |format|
      format.html { redirect_to manage_news_index_deleted_url, notice: "#{@manage_news.title}放入回收箱." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manage_news
      @manage_news = Manage::News.find(params[:id])
    end

    def set_mange_contests
      @manage_contests=Manage::Contest.all
    end
    def get_mange_contest_id
      @contest_id=params[:contest_id]
      if @contest_id
        @contest_id=@contest_id.to_i
        @contest_id=nil if @contest_id==-1
        #@find判断显示的咨询是全部还是某项赛事,true表示某项赛事,false表示全部
        @find=true
      else
        @find=false
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manage_news_params
      param=params.require(:manage_news).permit(:title, :author, :content, :is_draft, :publish_at,:contest_id)
      param[:admin_id] = @admin.id
      if params[:commit] == "存为草稿"
        param[:is_draft] = true
      else
        param[:is_draft] = false
      end
      param
    end
end
