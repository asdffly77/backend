class DemandsController < ApplicationController
  before_action :authenticate!
  def index
    @page_id = 'request'
    @demand = Demand.new
  end

  def create
    @demand = Demand.new(:creator => current_user)
    @demand.attributes = demand_params
    if @demand.save
      redirect_to root_path
      return
    end
    redirect_to demands_path
  end

  private
  def demand_params
    params.require(:demand).permit!
  end
end
