class AboutController < ApplicationController
  def index
    @page_id = 'index'
    @banners = Banner.about.where('start_at <= ? and end_at >= ?', Time.now, Time.now).where(:language => params[:locale] == 'en' ? [0, 1] : [0, 2])
  end
end
