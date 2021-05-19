# == Schema Information
#
# Table name: user_live_subscribes
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  live_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class UserLiveSubscribe < ApplicationRecord
  belongs_to :live
  belongs_to :user
end
