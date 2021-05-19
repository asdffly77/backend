# == Schema Information
#
# Table name: lives
#
#  id          :bigint           not null, primary key
#  live_type   :integer
#  name        :string(255)      not null
#  description :string(255)
#  stream_key  :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  image       :string(255)
#  status      :integer
#  company_id  :bigint
#  author      :string(255)
#  name_en     :string(255)
#  logo        :string(255)
#  source      :integer          default("streaming")
#  source_url  :text(4294967295)
#  ad_show     :boolean          default(FALSE)
#  slot        :integer          default(99)
#
class Live < ApplicationRecord
  mount_uploader :image, LiveImageUploader
  mount_uploader :logo, LiveLogoUploader

  has_many :attachments
  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  has_many :user_live_subscribes
  has_many :subscriped_users, :through => :user_live_subscribes, :source => :user
  has_many :comments
  has_many :barrages
  has_many :live_details
  include Hashid::Rails

  belongs_to :company, optional: true
  enum :live_type => {
    :canton_fair => 0, #广交会直播
    :activity => 1, #设计活动直播
    :design => 2, #设计公司直播
    :clothing => 3, #走秀企业直播
    :manufacture => 4, #供应链企业直播
  }
  enum :status => {
    :closing => 0, # 关闭
    :opening => 1, # 开启
  }

  enum :source => {
    :streaming => 0, # 直播
    :video => 1, # 视频
  }

  default_scope ->{ order('slot DESC, created_at DESC') }

  def self.search(keywords)
    search_for = %w(
      company_name
      company_name_en
      name
      name_en
      description
      author
    )
    Live.ransack(search_for.join('_or_') + '_cont' => keywords).result(:distinct => true)
  end
  

  def rtmp_live_address
    return stream_key if stream_key.split('=')[-1].hex - Time.now.to_i >= 3600 rescue nil
    address = TencentCloudService.get_live_address('rtmp.pdconline.org.cn', '11ce3b625f0986a4386574a0c9204faf', self.hashid, (Time.now + 24.hours).to_i)
    self.update(:stream_key => address)
    address
  end

  def live_address
    {
      :m3u8 => TencentCloudService.get_live_address('radio.pdconline.org.cn', '11ce3b625f0986a4386574a0c9204faf', self.hashid, (Time.now + 24.hours).to_i, '1080p', 'm3u8', 'https'),
      :flv => TencentCloudService.get_live_address('radio.pdconline.org.cn', '11ce3b625f0986a4386574a0c9204faf', self.hashid, (Time.now + 24.hours).to_i, '1080p', 'flv', 'https'),
      :rtmp => TencentCloudService.get_live_address('radio.pdconline.org.cn', '11ce3b625f0986a4386574a0c9204faf', self.hashid, (Time.now + 24.hours).to_i)
  }.to_json
  end
  

end
