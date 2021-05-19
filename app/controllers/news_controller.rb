class NewsController < ApplicationController
  def index
    @page_id = 'news'
    @new_classifies = NewClassify.all
    @scope = New.where('start_at <= ? and end_at >= ?', Time.now, Time.now)

    if params[:new_classify_id].present?
      @news = @scope.where(new_classify_id: params[:new_classify_id])
    else
      @news = @scope.all
    end
  end

  def show
    @page_id = 'newsDetail'
    @new_info = New.find(params[:id])
  end

  def edit
    redirect_to news_path(params[:id]) unless Staff.where(:email => current_user&.email).present?
    @page_id = 'editor'
    @new_info = New.find(params[:id])
  end

  def update
    redirect_to news_path(params[:id]) unless Staff.where(:email => current_user&.email).present?
    @new_info = New.find(params[:id])
    @new_info.update(new_params)
    redirect_to news_path(@new_info)
  end

  private
  def new_params
    params.delete('_method')
    params.require(:new).except('_method', 'authenticity_token').permit!
  end
  
  
end
