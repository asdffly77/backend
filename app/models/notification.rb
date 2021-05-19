# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  body       :text(65535)
#  is_active  :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Notification < ApplicationRecord

  scope :active, ->{ where(is_active: true) }

end
