class LogOutController < ApplicationController
  def index
    session[:user_id] = nil
    redirect_to root_path
  end
end
