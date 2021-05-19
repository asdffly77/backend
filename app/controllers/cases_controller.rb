class CasesController < ApplicationController
  def show
    @case = Case.find(params[:id])
    @page_id = 'case'
  end
  def edit
    @page_id = 'editor'
    @case_info = Case.find(params[:id])
  end

  def update
    @case_info = Case.find(params[:id])
    @case_info.update(case_params)
    redirect_to case_path(@case_info)
  end
  
  def create
    case_info = Case.new(case_params)
    case_info.company = current_user.company
    if case_info.save
      redirect_to cases_edit_dashboard_path(case_info)
      return
    end
    flash[:error] = case_info.errors.full_messages
    redirect_to cases_create_dashboard_index_path
  end

  def destroy
    @case_info = Case.find(params[:id])
    @case_info.destroy
    redirect_to cases_dashboard_index_path
  end
  
  private
  def case_params
    params.delete('_method')
    params.require(:case).except('_method', 'authenticity_token').permit!
  end
  
end
