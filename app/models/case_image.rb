# == Schema Information
#
# Table name: case_images
#
#  id         :bigint           not null, primary key
#  image      :string(255)
#  case_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CaseImage < ApplicationRecord
  belongs_to :case
  mount_uploader :image, CaseImageUploader

end
