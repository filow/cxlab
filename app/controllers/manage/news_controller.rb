class Manage::NewsController < ManageController
  before_action :set_manage_news, only: [:show, :edit, :update, :destroy]

  # GET /manage/news
  # GET /manage/news.json
  # 显示已发布的资讯
  def index
    @manage_news = Manage::News.where(is_draft: false,is_deleted: false).order(id: :desc).all
  end
  # GET /manage/news/index_draft
  # 显示草稿箱中的资讯
  def index_draft
    @manage_news = Manage::News.where(is_draft: true).order(id: :desc).all
  end
  # GET /manage/news/index_delete
  # 显示回收箱中的资讯
  def index_deleted
    @manage_news = Manage::News.where(is_deleted: true).order(id: :desc).all
  end
  def 
  # GET /manage/news/1
  # GET /manage/news/1.json
  def show
  end

  # GET /manage/news/new
  def new
    @manage_news = Manage::News.new
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def manage_news_params
      param=params.require(:manage_news).permit(:title, :author, :content, :is_draft, :publish_at,:contest_id)
      param[:admin_id] = @admin.id
      param[:pure_content]=param[:content].gsub(/<\/?.*?>/,"").gsub(/&\w+;/," ").gsub(/\s+/," ")
      param
    end
end
