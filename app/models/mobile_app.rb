# == Schema Information
#
# Table name: mobile_apps
#
#  id            :bigint           not null, primary key
#  name          :integer
#  version       :string(50)
#  secret        :string(32)
#  app_key       :string(32)
#  deprecated_at :date
#  attachment    :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class MobileApp < ApplicationRecord
  before_create :generate_key
  mount_uploader :attachment, MobileAppUploader
  #
  # Constants
  #
  enum :name => {
    :iOS   => 1,
    :android => 2
  }

  scope :active, lambda { where(:deprecated_at => nil)}
  #
  # Validations
  #
  validates :version, uniqueness: { scope: :name }

  #
  # 是否已经废弃不支持
  #
  #
  # @return [Boolean]
  #
  def deprecated?
    deprecated_at.present?
  end

  #
  # 将当前 MobileApp 设置为废弃的
  #
  #
  # @return [void]
  #
  def deprecate!
    self.update(:deprecated_at => Time.current)
  end

  def encode(payload)
    JWT.encode(payload, secret)
  end
  def decode(code)
    JWT.decode(code, secret)[0]
  end

  def upgrade_info
    info = {}
    if deprecated?
      if self.name == 'iOS'
        url = "itms-services://?action=download-manifest&url=#{ENV['HOST_URL']}/backend.plist"
      else
        url = "#{ENV['HOST_URL']}/backend.#{MobileApp.android.last.version}.apk"
      end
      info.merge!({
        :force_upgrade => true,
        :info => '当前版本已经过期，请下载新版本，如无法下载请删除本app后到官网重新下载。',
        :url => url
      })
    end
    info
  end

  private
  def generate_key
    self.app_key ||= SecureRandom.hex(10)
    self.secret ||= SecureRandom.hex(16)
  end

end
