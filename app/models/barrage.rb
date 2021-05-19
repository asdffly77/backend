# == Schema Information
#
# Table name: barrages
#
#  id         :bigint           not null, primary key
#  user_id    :bigint
#  live_id    :bigint
#  detail     :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Barrage < ApplicationRecord
  belongs_to :user
  belongs_to :live
  default_scope -> { order("created_at DESC")  }

end
