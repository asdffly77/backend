class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :set_locale

  def authenticate!
    unless current_user
      # p params[:controller]
      # session[:redirect_to] =  #if params[:controller] == 'chats'
      redirect_to new_session_path(:redirect_to => request.path)
    end
  end

  def current_user
    (@current_user ||= User.find(session[:user_id]) if session[:user_id]) rescue nil
  end

  def set_locale
    redirect_to root_path(:locale => I18n.default_locale) unless params[:locale]
    I18n.locale = params[:locale]
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
