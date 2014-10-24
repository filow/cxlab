class Manage::NewsController < ManageController
  before_action :set_manage_news, only: [:show, :edit, :update, :destroy]

  # GET /manage/news
  # GET /manage/news.json
  def index
    @manage_news = Manage::News.all
  end

  # GET /manage/news/1
  # GET /manage/news/1.json
  def show
  end

  # GET /manage/news/new
  def new
    @manage_news = Manage::News.new
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
        format.html { redirect_to @manage_news, notice: 'News was successfully created.' }
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
        format.html { redirect_to @manage_news, notice: 'News was successfully updated.' }
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
      format.html { redirect_to manage_news_index_url, notice: 'News was successfully destroyed.' }
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
      params.require(:manage_news).permit(:title, :author, :content, :pure_content, :is_draft, :publish_at)
    end
end
