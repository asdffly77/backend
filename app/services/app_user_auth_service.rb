class AppUserAuthService < ApplicationService
  attr_reader :user
  attr_reader :err_pack

  #
  # 初始化
  #
  # @param [Integer] user_token: nil
  # @param [Integer] user_id: nil
  # @param [String] sig: nil
  #
  def initialize(user_id: nil, user_token: nil, sig: nil)
    @user_token = user_token
    @user_id = user_id
    @sig = sig
  end

  #
  # 判断用户校验是否通过
  #
  #
  # @return [Boolean]
  #
  def authentic?
    @user = User.find_by(:id => @user_id)
    p @user
    if @user.nil?
      add_error("app_auth", "user_not_found", :http_status_code => 401)
      return false
    end
    unless sig_valid?
      add_error("app_auth", "user_not_found", :http_status_code => 401)
      return false
    end
    true
  end

  #
  # 检查是否为用户签名
  #
  #
  # @return [Boolean]
  #
  def sig_valid?
    (JWT.decode(@sig, @user.api_token) rescue nil) != nil
  end

end
