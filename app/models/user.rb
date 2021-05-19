# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  api_token       :string(255)
#  invite_code     :string(255)
#  parent_id       :integer
#  lft             :integer
#  rgt             :integer
#  depth           :integer
#  children_count  :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  user_type       :integer          default("purchase"), not null
#  user_remask     :string(255)
#  company_name    :string(255)
#  phone_number    :string(255)
#  name            :string(255)
#  image           :string(255)
#
class User < ApplicationRecord
  mount_uploader :image, AvatarUploader
  include Gravtastic
  gravtastic

  has_secure_password
  # acts_as_nested_set
  validates :invite_code, uniqueness: true
  validates :email, uniqueness: true
  # validates :api_token, uniqueness: true
  before_create :generate_invite_code
  after_create :create_im_user
  has_one :company

  has_many :user_live_subscribes
  has_many :subscription_lives, :through => :user_live_subscribes, :source => :live

  has_many :demands

  enum :user_type => {
    :purchase => 0, # 采购
    :production_enterprise => 1, # 供应链企业
    :designer => 2, # 设计师
    :other => 3, # 其他
  }

  def im_id
    service = YunyitongService.new(self)
    service.get_user_id
  end

  def create_im_user
    service = YunyitongService.new(self)
    service.create_user
  end

  def human_user_type
    case user_type
    when 'purchase'
      '采购商'
    when 'production_enterprise'
      '供应链企业'
    when 'designer'
      '设计师/设计企业'
    when 'other'
      '其他'
    end
  end
  
  
  private
  #
  # 生成用户的邀请码
  #
  #
  # @return [void]
  #
  def generate_invite_code
    return if self.invite_code
    begin
      charset = Array('A'..'Z') + Array(0..9)
      self.invite_code = Array.new(6) { charset.sample }.join
    end while User.where(:invite_code => self.invite_code).any?
  end
end
