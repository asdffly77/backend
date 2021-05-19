class SessionsController < ApplicationController
  layout 'sigin'
  def new
    @page_id = 'sigin'
    session[:redirect_to] = params[:redirect_to]
  end

  def create
    user = User.find_by(:email => params[:user][:email])
    p user && user.authenticate(params[:user][:password])
    unless user && user.authenticate(params[:user][:password])
      flash[:error] = I18n.t('wrong_login')
      redirect_to new_session_path
      return
    end
    session[:user_id] = user.id
    path_info = session[:redirect_to] || params[:redirect_to]
    if path_info.present?
      session[:redirect_to] = nil
      redirect_to path_info

    else
      redirect_to dashboard_index_path
    end
    
  end
  
end
