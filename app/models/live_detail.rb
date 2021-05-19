# == Schema Information
#
# Table name: live_details
#
#  id             :bigint           not null, primary key
#  live_id        :bigint
#  image          :string(255)
#  name           :string(255)
#  name_en        :string(255)
#  description    :text(4294967295)
#  description_en :text(4294967295)
#  url            :text(4294967295)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class LiveDetail < ApplicationRecord
  belongs_to :live
  mount_uploader :image, LiveDetailImageUploader
end
