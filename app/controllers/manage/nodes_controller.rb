class Manage::NodesController < ManageController
  before_action :set_manage_node, only: [:show]

  # GET /manage/nodes
  # GET /manage/nodes.json
  def index
    @manage_nodes = Manage::Node.tree_view
  end

  # GET /manage/nodes/1
  # GET /manage/nodes/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manage_node
      @manage_node = Manage::Node.find(params[:id])
    end
end
