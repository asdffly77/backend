class RecoverPasswordController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:send_code]
  layout 'sigin'
  def send_code
    if create_lock.get
      otp_secret = Rails.cache.fetch([:recover_password, params[:email]], expires_in: 30.minutes) do
        # '123456'
        '%06d' % SecureRandom.random_number(1000000)
      end
      VerifyMailer.with(locale: params[:locale].to_s, verify_code: otp_secret, email: params[:email]).code.deliver_now
      render :json => {:success => true}
    else
      render :json => {:success => false, :message => I18n.locale == :en ? 'Send too fast, please wait a moment.' : '发送过快，请稍等。'}
    end
    
  end

  def index
    @page_id = 'sigin'
  end

  def create
    secret = Rails.cache.read([:recover_password, params[:recover_password][:email]])
    if secret.nil? || params[:recover_password][:verify_code] != secret
      flash[:error] = params[:recover_password][:locale] == :en ? 'wrong verify code' : '验证码错误'
      redirect_to recover_password_index_path
      return
    end
    user = User.find_by(:email => params[:recover_password][:email])
    user&.update(:password => params[:recover_password][:password])
    redirect_to new_session_path
  end
  
  private

  def create_lock
    AtField::Lock.new(:name => 'recover_password', :scope => params[:email], :expiry => 60)
  end
  
end
