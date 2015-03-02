class ApiController < ApplicationController
  def professions
    @professions = Manage::Profession.tree_view
  end
end
