# == Schema Information
#
# Table name: cases
#
#  id            :bigint           not null, primary key
#  name          :text(4294967295)
#  detail        :text(4294967295)
#  detail_en     :text(4294967295)
#  three_d_model :string(255)
#  company_id    :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  name_en       :text(4294967295)
#  video         :text(4294967295)
#
class Case < ApplicationRecord
  belongs_to :company
  has_many :case_images
  accepts_nested_attributes_for :case_images, reject_if: :all_blank, allow_destroy: true

  mount_uploader :three_d_model, Case3DmodelUploader

  def self.search(keywords)
    search_for = %w(
      company_name
      company_name_en
      name
      name_en
      detail
      detail_en
    )
    Live.ransack(search_for.join('_or_') + '_cont' => keywords).result(:distinct => true)
  end

  def home_description
    a = JSON.parse(self.detail_i18n_show)
    a["blocks"][1]["data"]["text"] 
  rescue 
    nil
  end
end
