class Manage::CompetesController < ManageController
  before_action :set_manage_compete, only: [:show, :edit, :update, :destroy]
  before_action :set_contest_select_field, only: [:index, :new, :edit, :create, :update]

  # GET /manage/competes
  # GET /manage/competes.json
  def index
    @manage_competes = Manage::Compete.all
  end

  # GET /manage/competes/1
  # GET /manage/competes/1.json
  def show
  end

  # GET /manage/competes/new
  def new
    @manage_compete = Manage::Compete.new
  end

  # GET /manage/competes/1/edit
  def edit
  end

  # POST /manage/competes
  # POST /manage/competes.json
  def create
    @manage_compete = Manage::Compete.new(manage_compete_params)

    respond_to do |format|
      if @manage_compete.save
        format.html { redirect_to @manage_compete, notice: 'Compete was successfully created.' }
        format.json { render :show, status: :created, location: @manage_compete }
      else
        format.html { render :new }
        format.json { render json: @manage_compete.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /manage/competes/1
  # PATCH/PUT /manage/competes/1.json
  def update
    respond_to do |format|
      if @manage_compete.update(manage_compete_params)
        format.html { redirect_to @manage_compete, notice: 'Compete was successfully updated.' }
        format.json { render :show, status: :ok, location: @manage_compete }
      else
        format.html { render :edit }
        format.json { render json: @manage_compete.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /manage/competes/1
  # DELETE /manage/competes/1.json
  def destroy
    @manage_compete.destroy
    respond_to do |format|
      format.html { redirect_to manage_competes_url, notice: 'Compete was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manage_compete
      @manage_compete = Manage::Compete.find(params[:id])
    end

    def set_contest_select_field
      @contest_select_field = Manage::Contest.select(:id,:name).collect{|x| [x.name,x.id]}
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def manage_compete_params
      param = params.require(:manage_compete).permit(:start_time, :end_time, :contest_id)
      param[:admin_id] = @admin.id
      param
    end
end
