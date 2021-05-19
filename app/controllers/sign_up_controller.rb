class SignUpController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:send_code]
  layout "sigin"
  def index
    @page_id = 'sigin'
  end

  def send_code
    if create_lock.get
      otp_secret = Rails.cache.fetch([:user, params[:email]], expires_in: 30.minutes) do
        # '123456'
        '%06d' % SecureRandom.random_number(1000000)
      end
      VerifyMailer.with(locale: params[:locale].to_s, verify_code: otp_secret, email: params[:email]).code.deliver_now
      render :json => {:success => true}
    else
      render :json => {:success => false, :message => I18n.locale == :en ? 'Send too fast, please wait a moment.' : '发送过快，请稍等。'}
    end
    
  end

  def create
    secret = Rails.cache.read([:user, params[:user][:email]])
    if secret.nil? || params[:user][:verify_code] != secret
      flash[:error] = params[:user][:locale] == :en ? 'wrong verify code' : '验证码错误'
      redirect_to sign_up_index_path
      return
    end
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      path_info = session[:redirect_to] || params[:redirect_to]
      if path_info.present?
        session[:redirect_to] = nil
        redirect_to path_info
      else
        redirect_to root_path
      end
      return
    end
    flash[:error] = user.errors.full_messages
    redirect_to sign_up_index_path
  end

  private
  def user_params
    params.require(:user).except('verify_code', 'terms_of_service').permit!
  end

  def create_lock
    AtField::Lock.new(:name => 'sign_up', :scope => params[:email], :expiry => 60)
  end
end
