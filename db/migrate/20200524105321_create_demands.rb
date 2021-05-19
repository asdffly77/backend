class CreateDemands < ActiveRecord::Migration[6.0]
  def change
    create_table :demands do |t|
      t.references :user
      t.string :company_name
      t.integer :company_type
      t.string :scope_of_business
      t.integer :income_type
      t.string :contract_name
      t.string :contract_phone_number
      t.string :contract_email
      t.string :contract_address
      t.integer :demand_type
      t.integer :product_type
      t.datetime :end_at
      t.longtext :detail

      t.timestamps
    end
  end
end

# 企业名称
# 身份类别（设置成可选择标签）
# 经营范围
# "年营业额（人民币）
# （设置成可选择标签）"
# 联系人
# 联系电话
# 邮箱
# 联系地址
# 需求类型（设置成可选择标签）
# 产品类别（设置成可选择标签）
# 需求响应时限（指需求发布后超过响应时限则需求失效）
# 需求详细描述