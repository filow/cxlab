class Manage::CompetesController < ManageController
  before_action :set_manage_compete, only: [:show, :edit, :update, :destroy]
  before_action :set_contest_select_field, only: [:index, :new, :edit, :create, :update]

  # GET /manage/competes
  # GET /manage/competes.json
  def index
    @contests = Manage::Contest.order(is_deleted: :desc,id: :desc).to_a
    @contests.sort! do |a,b|
      if a.current_compete != 0
        if b.current_compete != 0
          # 如果两个比赛都有对应的正在进行的赛事，就按比赛数量逆序排列
          b.competes_count <=> a.competes_count
        else
          # 如果只有a有，那么a排前面
          -1
        end
      else
        if b.current_compete != nil
          # 如果只有b有，那么b排前面
          1
        else
          # 如果都没有，也按照比赛数量逆序排序
          b.competes_count <=> a.competes_count
        end
      end
    end

    @competes = @contests[0].competes.order(start_time: :desc)
    if params[:contest]
      current = @contests.find_all {|x| x.id == params[:contest].to_i}
      if current.length > 0
        @current = current[0]
      end
    end
    @current ||= @contests[0]
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
