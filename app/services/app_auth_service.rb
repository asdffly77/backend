class AppAuthService < ApplicationService
  attr_reader :mobile_app
  attr_reader :user_info

  # 设置 timestamp 允许的范围
  # 开发环境上下浮动不超过12小时
  # 正式环境上下浮动不超过70分钟
  TIMEOUT = Rails.env.development? ? 12.hours : 70.minutes

  AVALIABLE_ATTRS = %w(app_key)

  #
  # 初始化
  #
  # @param [Integer] timestamp
  # @param [String] token
  # @param [String] app_key
  #
  def initialize(token: nil, app_key: nil)
    @token = token
    @app_key = app_key
  end

  def authentic?
    unless auth_params_valid?
      add_error("app_auth", "wrong_params")
      return false
    end

    @mobile_app = MobileApp.find_by(:app_key => @app_key)
    unless @mobile_app
      add_error('app_auth', 'app_not_found')
      return
    end

    # if @mobile_app.version != '2.0.0'
    #   add_error("app_auth", "need_upgrade")
    #   @auth_result = false
    #   return false
    # end
    
    @user_info = @mobile_app.decode(@token) rescue nil
    unless @user_info
      add_error('app_auth', 'app_not_found')
      return
    end

    @timestamp = @user_info["timestamp"]

    unless timestamp_valid?
      add_error("app_auth", "timeout")
      @auth_result = false
      return false
    end


    true
  end


  #
  # 验证传入参数是否合法
  #
  #
  # @return [Boolean]
  #
  def auth_params_valid?
    AVALIABLE_ATTRS.each do |x|
      return false if !instance_variable_get("@#{x}").present?
    end

    true
  end

  #
  # 验证时间戳是否合法
  #
  # 两种情况将会返回错误
  #
  # 1. `@timestamp` 不是一个 valid 的 Integer
  # 2. `@timestamp` 时间戳和当前时间相差超过 `AppAuthService::TIMEOUT`
  #
  # @return [Boolean]
  #
  def timestamp_valid?
    if @timestamp.to_i <= 0 || (Time.current.to_i - @timestamp.to_i).abs > TIMEOUT
      return false
    end

    true
  end
end
