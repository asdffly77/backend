class Api::V1::UsersController < Api::V1::BaseController
  def create
    inviter = User.find_by(:invite_code => params[:invite_code])
    # unless inviter
    #   render_err_item(ErrItem.new('user', 'wrong_invite_code'))
    #   return
    # end
    # secret = Rails.cache.read([:verify, params[:phone_number]])
    # if secret.nil? || params[:verify_code] != secret
    #   render_err_item(ErrItem.new('sms', 'bad_verify_code'))
    #   return
    # end
    @user = (inviter&.children || User).new(user_params)
    @user.api_token = SecureRandom.hex(16)
    if @user.save
      payload = {
        :user_id => @user.id,
        :api_token => @user.api_token
      }
      # member = @mobile_app.encode(payload)
      render :json => {
        :success => true,
        :data => payload
      }
      return
    end
    render_err_pack(@user.err_pack)
  end

  def user_params
    params.permit(:email, :password, :password_confirmation )
  end
end