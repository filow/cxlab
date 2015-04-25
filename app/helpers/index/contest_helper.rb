module Index::ContestHelper
  def is_active_nav(type)
    if type == params[:id].to_i
      'active'
    end
  end
end
