class HomeController < ApplicationController
  # layout :application
  def index
    @page_id = 'index'
    @banners = Banner.home.where('start_at <= ? and end_at >= ?', Time.now, Time.now).where(:language => params[:locale] == 'en' ? [0, 1] : [0, 2])
    @banner_companies = Banner.home_company.where('start_at <= ? and end_at >= ?', Time.now, Time.now).where(:language => params[:locale] == 'en' ? [0, 1] : [0, 2])
    @vip_design_companies = Company.vip_index.allow.design.first(8)
    @vip_clothing_companies = Company.vip_index.allow.clothing.first(8)
    @banner_lives = Banner.home_live.where('start_at <= ? and end_at >= ?', Time.now, Time.now).where(:language => params[:locale] == 'en' ? [0, 1] : [0, 2])
    @vip_news = New.vip.where('start_at <= ? and end_at >= ?', Time.now, Time.now).first(4)
    @links = FriendLink.all
    @home_function_weeks = Banner.home_function_week.where('start_at <= ? and end_at >= ?', Time.now, Time.now).where(:language => params[:locale] == 'en' ? [0, 1] : [0, 2])

    @notification = Notification.active.first
  end
end
