# == Schema Information
#
# Table name: news
#
#  id              :bigint           not null, primary key
#  name            :string(255)
#  name_en         :string(255)
#  detail          :text(4294967295)
#  detail_en       :text(4294967295)
#  start_at        :datetime
#  end_at          :datetime
#  new_type        :integer          default("normal"), not null
#  image           :string(255)
#  new_classify_id :bigint
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  slot            :integer          default(0)
#
class New < ApplicationRecord
  belongs_to :new_classify
  mount_uploader :image, NewImageUploader
  enum :new_type => {
    :normal => 0, # 普通新闻
    :vip => 1, # 推荐新闻
  }
  default_scope -> { order("slot DESC, id DESC")  }
  def self.search(keywords)
    search_for = %w(
      name
      name_en
      detail
      detail_en
    )
    New.ransack(search_for.join('_or_') + '_cont' => keywords).result(:distinct => true)
  end

  def home_description
    a = JSON.parse(self.detail_i18n_show)
    a["blocks"][1]["data"]["text"] 
  rescue 
    nil
  end
  
end
