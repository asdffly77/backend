class SearchController < ApplicationController
  def index
    @page_id = 'search'
    case params[:type]
    when 'company'
      @results = Company.human_search(params[:key])
    when 'clothing'
      @results = Company.human_search(params[:key], 'clothing')
    when 'live'
      @results = Live.search(params[:key])
    when 'new'
      @results = New.search(params[:key])
    end
  # rescue
  #   @results = nil
  end
  
end
