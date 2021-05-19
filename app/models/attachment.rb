# == Schema Information
#
# Table name: attachments
#
#  id         :bigint           not null, primary key
#  file       :string(255)
#  live_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Attachment < ApplicationRecord
  mount_uploader :file, AttachmentUploader
  belongs_to :live
end
