class Api::V1::SessionsController < Api::V1::BaseController
  before_action :authenticate_user!, :only => %w(destroy)

  def create
    service = AuthUserService.new(token_params)
    if service.perform
      @user = service.user
      @user.update(:api_token => SecureRandom.hex(16))
      payload = {
        :user_id => @user.id,
        :api_token => @user.api_token
      }
      render :json => {
        :success => true,
        :data => payload
      }
    else
      render_err_pack(service.err_pack)
    end
  end

  def destroy
    current_user.update(:api_token => nil)
    render :json => {
      :success => true
    }
  end
  private
  
  def token_params
    params.permit(:login, :password)
  end

end