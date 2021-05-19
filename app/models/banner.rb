# == Schema Information
#
# Table name: banners
#
#  id          :bigint           not null, primary key
#  image       :string(255)
#  start_at    :datetime
#  end_at      :datetime
#  slot        :integer
#  url         :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  banner_type :integer          default("home"), not null
#  language    :integer          default("all_lang")
#
class Banner < ApplicationRecord
  mount_uploader :image, BannerImageUploader
  enum :banner_type => {
    :home => 0, # 首页banner
    :home_company => 1, # 首页推荐公司
    :home_live => 2, # 首页推荐直播
    :companies => 3, # 设计展示banner
    :function_week => 4, # 广交会时尚周banner
    :activity => 5, # 时尚活动
    :home_function_week => 6, # 首页时尚周下面banner
    :home_function_week_company => 7, # 首页时尚周推荐公司
    :about => 8, # about页面的banner
    :live_show => 9, # 直播详情页面广告
  }
  enum :language => {
    :all_lang => 0, # 所有语言
    :en => 1, # 仅英文
    :cn => 2, # 仅中文
  }
end
