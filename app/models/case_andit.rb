# == Schema Information
#
# Table name: case_andits
#
#  id         :bigint           not null, primary key
#  detail     :text(4294967295)
#  detail_en  :text(4294967295)
#  case_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CaseAndit < ApplicationRecord
end
