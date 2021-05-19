class ChatsController < ApplicationController
  before_action :authenticate!
  layout false, :only => [:show]
  def index
    @page_id = 'dashboardCompany'
    @token = YunyitongService.new(current_user).user_token
  end

  def show
    service = YunyitongService.new(current_user)
    @token = service.user_token
    # 创建聊天
    @company_user_id = User.find(params[:id]).im_id
    service.create_chat(@company_user_id)
  end
  
  
end
