# == Schema Information
#
# Table name: staffs
#
#  id                        :bigint           not null, primary key
#  email                     :string(255)
#  password_digest           :string(255)
#  first_name                :string(255)
#  last_name                 :string(255)
#  remember_token            :string(255)
#  remember_token_expires_at :datetime
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#
class Staff < ApplicationRecord
  include Trestle::Auth::ModelMethods
  include Trestle::Auth::ModelMethods::Rememberable
  def locale
    :"zh-CN"
  end
end
