# == Schema Information
#
# Table name: new_classifies
#
#  id      :bigint           not null, primary key
#  name    :string(255)
#  name_en :string(255)
#
class NewClassify < ApplicationRecord
  has_many :news, :class_name => 'New'
end
