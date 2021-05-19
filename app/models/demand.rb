# == Schema Information
#
# Table name: demands
#
#  id                    :bigint           not null, primary key
#  user_id               :bigint
#  company_name          :string(255)
#  company_type          :integer
#  scope_of_business     :string(255)
#  income_type           :integer
#  contract_name         :string(255)
#  contract_phone_number :string(255)
#  contract_email        :string(255)
#  contract_address      :string(255)
#  demand_type           :integer
#  product_type          :integer
#  end_at                :datetime
#  detail                :text(4294967295)
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  slot                  :integer          default(0)
#
class Demand < ApplicationRecord
  has_many :demand_relations
  has_many :viewers, :through => :demand_relations, :source => :company

  belongs_to :creator, :class_name => 'User', :foreign_key => 'user_id'

  default_scope -> { order("slot DESC, created_at DESC")  }
  enum :company_type => {
    :manufacturer => 0, # 供应链企业
    :trading_company => 1, # 贸易公司
    :retailer => 2, # 零售商
    :wholesaler => 3, # 批发商
    :importer => 4, # 进口商
    :designer => 5, # 设计师/设计机构
    :foreign_buyers => 6, # 国外采购商
    :other => 7, # 其他
  }

  enum :income_type => {
    :five_million => 0, # 500万以下
    :twenty_million => 1, # 500-2000万
    :fifty_million => 2, # 2000-5000万
    :one_hundred_million => 3, # 5000万-1亿
    :up_one_hundred_million => 4, # 1亿~
  }
  enum :demand_type => {
    :design => 0, # 找设计
    :product => 1, # 找产品
    :market => 2, # 找市场
  }
  enum :product_type => {
    :electronics_and_home_appliances => 0, # 电子及家电类
    :lighting => 1, # 照明类
    :vehicles_and_accessories => 2, # 车辆及配件类
    :mechanical => 3, # 机械类
    :hardware_tools => 4, # 五金工具类
    :building_materials => 5, # 建材类
    :chemical_products => 6, # 化工产品类
    :energy => 7, # 能源类
    :consumer_goods => 8, # 日用消费品类
    :gifts => 9, # 礼品类
    :home_decoration => 10, # 家居装饰品类
    :textile => 11, # 纺织类
    :clothing => 12, # 服装类
    :footwear => 13, # 鞋类
    :office_stationery => 14, # 办公文具类
    :luggage => 15, # 箱包类
    :sports_travel_and_leisure_products => 16, # 体育及旅游休闲用品
    :medicine_and_healthcare => 17, # 医药及医疗保健类
    :foodstuffs => 18, # 食品类
  }

end

