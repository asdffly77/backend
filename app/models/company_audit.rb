# == Schema Information
#
# Table name: company_audits
#
#  id             :bigint           not null, primary key
#  company_id     :bigint
#  description    :text(4294967295)
#  description_en :text(4294967295)
#  detail         :text(4294967295)
#  detail_en      :text(4294967295)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  status         :integer          default("waiting"), not null
#  name           :string(255)
#  name_en        :string(255)
#  phone_number   :string(255)
#
class CompanyAudit < ApplicationRecord
  belongs_to :company
  enum :status => {
    :waiting => 0,
    :rejected => 1
  }

  def allow
    a = self.company
    a.update!({
      :description => self.description,
      :description_en => self.description_en,
      :detail => self.detail,
      :detail_en => self.detail_en,
      :name => self.name,
      :name_en => self.name_en,
      :phone_number => self.phone_number,
    })
    self.destroy
  end

  def reject
    self.update(:status => :rejected)
  end
  
end
