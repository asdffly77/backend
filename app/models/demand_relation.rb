# == Schema Information
#
# Table name: demand_relations
#
#  id         :bigint           not null, primary key
#  company_id :bigint
#  demand_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class DemandRelation < ApplicationRecord
  belongs_to :company, optional: true
  belongs_to :demand, optional: true
end
