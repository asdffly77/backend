# == Schema Information
#
# Table name: friend_links
#
#  id         :bigint           not null, primary key
#  image      :string(255)
#  name       :string(255)
#  url        :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class FriendLink < ApplicationRecord
  mount_uploader :image, FriendLinkUploader
end
