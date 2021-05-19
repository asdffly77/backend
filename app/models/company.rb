# == Schema Information
#
# Table name: companies
#
#  id                            :bigint           not null, primary key
#  company_type                  :integer          default("design"), not null
#  name                          :string(255)
#  name_en                       :string(255)
#  description                   :text(4294967295)
#  description_en                :text(4294967295)
#  detail                        :text(4294967295)
#  detail_en                     :text(4294967295)
#  company_classify_relations_id :bigint
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  status                        :integer          default("disabled"), not null
#  recommended                   :integer          default("normal"), not null
#  logo                          :string(255)
#  user_id                       :bigint
#  phone_number                  :string(255)
#  slot                          :integer          default(0)
#
class Company < ApplicationRecord
  has_many :company_classify_relations
  has_many :company_classifies, through: :company_classify_relations
  has_many :cases
  has_one :live
  belongs_to :user, :optional => true

  has_many :demand_relations
  has_many :viewed_demands, :through => :demand_relations, :source => :demand
  before_save :set_company_classifies
  enum :company_type => {
    :design => 0, #设计公司
    :clothing => 1, #服装企业（走秀）
    :manufacture => 2, # 供应链企业
    :other => 3 #其他
  }

  enum :recommended => {
    :normal => 0, # 非推荐
    :vip => 1, # 推荐到首页
  }

  enum :status => {
    :disabled => 0, # 不允许
    :allow => 1, # 允许
  }

  validates :name, presence: true, uniqueness: true
  # validates :name_en, presence: true, uniqueness: true
  mount_uploader :logo, CompanyLogoUploader
  scope :vip_index, -> { where(:recommended => 'vip').order('slot DESC')}
  scope :human_order, ->{ order('slot DESC, RAND()') }
  
  def self.human_search(keywords, company_type = "design")
    search_for = %w(
      company_classifies_name
      company_classifies_name_en
      name
      name_en
      description
      description_en
      detail
      detail_en
    )
    Company.ransack(search_for.join('_or_') + '_cont' => keywords).result(:distinct => true).send(company_type)
  end
  
  def company_audit
    audit = CompanyAudit.find_or_initialize_by(:company => self)
    audit.update(:description => self.description, :description_en => self.description_en, :detail => self.detail, :detail_en => self.detail_en, :name => self.name, :name_en => self.name_en, :phone_number => self.phone_number) if audit.new_record?
    audit
  end
  
  def home_description
    a = JSON.parse(self.detail_i18n_show)
    a["blocks"][1]["data"]["text"] 
  rescue 
    nil
  end

  def set_company_classifies
    p '123123'
    p self.company_classifies
  end
  
  
end
