# == Schema Information
#
# Table name: company_classify_relations
#
#  id                  :bigint           not null, primary key
#  company_id          :bigint
#  company_classify_id :bigint
#
class CompanyClassifyRelation < ApplicationRecord
  belongs_to :company
  belongs_to :company_classify
  
end
