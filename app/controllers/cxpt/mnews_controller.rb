class Cxpt::MnewsController < ManageController
  before_action :set_cxpt_mnews, only: [:show, :edit, :update, :destroy]

  # GET /cxpt/mnews
  # GET /cxpt/mnews.json
  def index
    @cxpt_mnews = Cxpt::Mnews.all
  end

  # GET /cxpt/mnews/1
  # GET /cxpt/mnews/1.json
  def show
  end

  # GET /cxpt/mnews/new
  def new
    @cxpt_mnews = Cxpt::Mnews.new
  end

  # GET /cxpt/mnews/1/edit
  def edit
  end

  # POST /cxpt/mnews
  # POST /cxpt/mnews.json
  def create
    @cxpt_mnews = Cxpt::Mnews.new(cxpt_mnews_params)

    respond_to do |format|
      if @cxpt_mnews.save
        format.html { redirect_to @cxpt_mnews, notice: 'Mnews was successfully created.' }
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
    respond_to do |format|
      if @cxpt_mnews.update(cxpt_mnews_params)
        format.html { redirect_to @cxpt_mnews, notice: 'Mnews was successfully updated.' }
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
      format.html { redirect_to cxpt_mnews_index_url, notice: 'Mnews was successfully destroyed.' }
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
      params.require(:cxpt_mnews).permit(:title, :content, :summary, :author, :publish_at, :view_count, :cxcate_id)
    end
end
