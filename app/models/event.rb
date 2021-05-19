# == Schema Information
#
# Table name: events
#
#  id         :bigint           not null, primary key
#  title      :string(255)
#  url        :string(255)
#  time       :string(255)
#  slot       :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tags       :string(255)
#  event_type :integer
#
class Event < ApplicationRecord

  validates :title, :time, :url, presence: true

  default_scope ->{ order('slot DESC, created_at DESC') }
 
  enum event_type: {
    fashion: 0, #广交会时尚周
    design: 1, #设计活动
  }

  def human_tags
    tags.split(' ')
  end

end
