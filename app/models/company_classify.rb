# == Schema Information
#
# Table name: company_classifies
#
#  id            :bigint           not null, primary key
#  name          :string(255)      not null
#  name_en       :string(255)      not null
#  classify_type :integer          default("design"), not null
#
class CompanyClassify < ApplicationRecord
  has_many :company_classify_relations
  has_many :companies, :through => :company_classify_relations
  enum :classify_type => {
    :design => 0,
    :clothing => 1,
    :for_search => 2, # 专为搜索设置
    :manufacture => 3
  }
end
