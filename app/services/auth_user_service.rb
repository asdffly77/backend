class AuthUserService < ApplicationService
  attr_reader :user
  def initialize(args)
    @args = args
  end

  def perform
    user = User.find_by(:email => @args[:login])
    unless user
      wrong_login
      return false
    end
    @user = user.authenticate(@args[:password])
    unless @user
      wrong_login
      return false
    end
    true
  end

  def wrong_login
    add_error('auth_user_service', 'wrong_phone')
  end

end
