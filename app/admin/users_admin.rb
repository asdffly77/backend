Trestle.resource(:users) do
  menu do
    item '用户管理', icon: "fa fa-star"
  end

  search_form do |q|
    text_field :company_name_cont, label: '公司名', readonly: false
    sidebar do
      link_to '导出', admin.path(:export, **request.query_parameters.symbolize_keys.merge(format: :xls)), class: "btn btn-primary btn-block"
    end
  end

  scopes do
    scope '所有用户', -> { User.all }, default: true
    scope '采购商', ->{ User.purchase }
    scope '供应链企业', ->{ User.production_enterprise }
    scope '设计师', ->{ User.designer }
    scope '其他', ->{ User.other }
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :email
    column :user_type do |user|
      case user.user_type
      when 'purchase'
        '采购商'
      when 'production_enterprise'
        '供应链企业'
      when 'designer'
        '设计师/设计企业'
      when 'other'
        '其他'
      end
    end
    column :user_remask
    column :company_name
    column :phone_number
    column :name
    column :created_at
    column :image do |user|
      image_tag user.image&.url if user.image.present?
    end
    actions
  end
  # Customize the form fields shown on the new/edit views.
  #
  form do |user|
    '无此功能'
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:user).permit(:name, ...)
  # end

  controller do
    def export
      scope = params[:scope].presence

      @scope = case scope
      when nil
        User.all
      when '采购商'
        User.purchase
      when '供应链企业'
        User.production_enterprise
      when '设计师'
        User.designer
      when '其他'
        User.other
      end
      
      @q = @scope.order(created_at: :desc).ransack(params[:q])
      @users = @q.result(distinct: true)

      respond_to do |format|
        format.xls { export_xls(@users) }
      end
    end

    def export_xls(users)
      book        = Spreadsheet::Workbook.new
      sheet       = book.create_worksheet
      sheet.name  = '用户'
      headers     = ['ID', 'Email', '用户类型', '用户类型（其他）', '企业名称', '电话号码', '名字', '创建日期']

      sheet.row(0).concat(headers)

      users.each_with_index do |user, index|
        attrs = []
        attrs << user.id
        attrs << user.email
        attrs << user.human_user_type
        attrs << user.user_remask
        attrs << user.company_name
        attrs << user.phone_number
        attrs << user.name
        attrs << user.created_at.strftime('%Y-%m-%d %H:%M')

        sheet.update_row *attrs.unshift(index+1)
      end

      book.write Rails.root.join("data/users.xls").to_s
      send_file Rails.root.join("data/users.xls").to_s, type: :xls
    end
  end

  routes do
    get :export, on: :collection
  end
end
