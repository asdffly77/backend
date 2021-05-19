class Api::BaseController < ActionController::Base
  skip_before_action :verify_authenticity_token

  before_action :authenticate_app!# unless Rails.env.development?
  # before_action :set_locale
  before_action :get_user# unless Rails.env.development?
  # before_action :server_shutdown!

  helper_method :current_user, :mobile_app
  attr_accessor :current_user, :mobile_app
  
  # rescue_from Account::InsufficientBalanceError, with: :render_insufficient_balance_error
  
  layout 'api/v1/layouts/application.json'


  #
  # 验证 App 请求是否合法
  #
  #
  # @return [void]
  #
  def authenticate_app!
    app_key  = request.headers["X-App-Key"] || params[:app_key] || params[:id_document][:app_key]
    token    = request.headers["X-App-Auth"] || params[:app_auth] || params[:id_document][:app_auth]

    app_auth = AppAuthService.new(token: token, app_key: app_key)

    if !app_auth.authentic?
      # 没有通过验证
      # Todo 记录错误app信息
      # log_data = {
      #   :index              => "wrong-app-auth",
      #   :ip                 => request.ip,
      #   :server_time        => Time.now.strftime('%Y-%m-%d %H:%M:%S %z'),
      #   :err_code           => app_auth.err_pack.err_items.first.code,
      #   :err_msg            => app_auth.err_pack.err_items.first.message,
      #   :path               => request.path,
      #   :params_app_name    => app_name.to_s,
      #   :params_app_version => app_version.to_s,
      #   :params_auth1       => sign,
      #   :params_timestamp   => timestamp,
      #   :params_user_id     => headers["X-User-Id"],
      #   :params_auth2       => headers["X-Auth-2"]
      # }

      # Raven.send_event(log_data)

      # 2. 返回错误信息。
      render_err_pack(app_auth.err_pack)
      return
    end
    @mobile_app = app_auth.mobile_app
    @user_info = app_auth.user_info.with_indifferent_access
  end

  #
  # 尝试获取用户
  #
  # 如果用户验证成功，将会赋值 `@current_user`
  # 如果用户验证失败，将会赋值 `@user_sign_in_err_pack`
  #
  #
  # @return [void]
  #
  def get_user
    @user_info = {} unless @user_info["member_id"].present?
    return unless @user_info
    app_user_auth = AppUserAuthService.new(user_id: @user_info["member_id"], sig: @user_info["sig"])

    if app_user_auth.authentic?
      # 如果验证成功，设置 `@current_user`
      @current_user = app_user_auth.user
    else
      # 如果验证失败，设置 `@user_sign_in_err_pack`
      @user_sign_in_err_pack = app_user_auth.err_pack
    end
  end

  #
  # 要求当前用户登录
  #
  # 如果当前用户没有登录则直接 render @user_sign_in_err_pack
  #
  #
  # @return [void]
  #
  def authenticate_user!
    # @current_user = User.first if Rails.env.development?
    render_err_pack(@user_sign_in_err_pack) if !user_signed_in?
  end

  #
  # 当前用户是否登录
  #
  #
  # @return [Boolean]
  #
  def user_signed_in?
    @current_user.present?
  end

  #
  # Render 一个 ErrItem 中定义的错误信息
  #
  # @param [ErrItem] err_item
  # @param [Integer] http_status_code=200
  # @return [void]
  def render_err_item(err_item, http_status_code = 200)
    render :json => { :success => false, :errors => [err_item.to_h] }, :status => http_status_code
  end

  #
  # Render 一个 ErrPack 中定义的错误信息
  #
  # @param [ErrPack] err_pack
  #
  # @return [void]
  #
  def render_err_pack(err_pack)
    render :json => { :success => false, :errors => err_pack.err_items.map { |item| item.to_h } }.to_json,
      :status => err_pack.http_status_code
  end

  #
  # 设置默认语言
  #
  #
  # @return [void]
  #
  # def set_locale
  #   I18n.locale = "zh-CN"
  # end

  #
  # 验证验证码
  #
  #
  # @return [void]
  #
  def auth_captcha!
    # if verify_rucaptcha? params[:_rucaptcha]
    #   return
    # end
    # render_err_item(ErrItem.new("captcha", "error"))
    true
  end

  def auth_id_document!
    render_err_item(ErrItem.new('identity', 'need_auth')) unless current_user.id_document.verified?
  end

  def server_shutdown!
    render_err_item(ErrItem.new('server', 'shutdown'))
  end
  protected
  def render_insufficient_balance_error
    render_err_item(ErrItem.new('account', 'insufficient_balance'))
  end
end
