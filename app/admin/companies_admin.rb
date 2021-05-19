Trestle.resource(:companies) do
  menu do
    item '公司管理', icon: "fa fa-star"
  end

  # search_form do |q|
  #   text_field :name_cont, label: '公司名', readonly: false
  # end

  scopes do
    scope '全部', -> {Company.all},  default: true
    scope '线上申请中', -> { Company.disabled }
    scope '内容修改审核中', -> { Company.where(:id => CompanyAudit.all.waiting.pluck(:company_id)) }
    scope '内容审核未通过', -> { Company.where(:id => CompanyAudit.all.rejected.pluck(:company_id)) }
    # scope :drafts, -> { Post.unpublished }

    scope '设计公司', ->{ Company.design }
    scope '走秀企业', ->{ Company.clothing }
    scope '供应链企业', ->{ Company.manufacture }
    scope '其他企业', ->{ Company.other }
  end

  table do
    column '公司名' do |company|
      company.name + "(#{company.name_en})"
    end
    column '手机号' do |company|
      company.user&.phone_number
    end
    column '公司类型' do |company|
      case company.company_type
      when 'design'
        '设计公司'
      when 'clothing'
        '走秀企业'
      when 'manufacture'
        '供应链企业'
      when 'other'
        '其他'
      end
    end
    column '直播间' do |company|
      if company.live.present? 
        link_to '查看直播间', main_app.life_path(company.live, :locale => 'zh-CN')
      else
        button_to '开通直播', create_live_companies_admin_path(company), action: :allow, method: :post, style: :success, icon: "fa fa-check"
      end
    end
    column '公司状态' do |company|
      if company.disabled?
        a = '线上申请中'
      end
      if company.allow? && CompanyAudit.where(:company_id => company.id).waiting.exists?
        a = '内容修改审核中'
      end
      if CompanyAudit.where(:company_id => company.id).rejected.exists?
        a = '内容审核未通过'
      end
      a ||= '正常'
    end
    column '分类' do |company|
      company.company_classifies&.pluck(:name).join('|')
    end
    actions do |toolbar, instance, admin|
      if instance.disabled?
        toolbar.link '通过申请', instance, action: :allow, method: :post, style: :success, icon: "fa fa-check"
        toolbar.link '拒绝申请', instance, action: :disable, method: :post, style: :danger, icon: "fa fa-times"
      end
      if instance.allow? && CompanyAudit.where(:company_id => instance.id).waiting.exists?
        toolbar.link '允许发布', instance, action: :detail_allow, method: :post, style: :success, icon: "fa fa-check"
        toolbar.link '拒绝发布', instance, action: :detail_disable, method: :post, style: :danger, icon: "fa fa-times"
      end
      if CompanyAudit.where(:company_id => instance.id).waiting.exists?
        toolbar.link '查看', main_app.company_path(instance, :locale => :en, :audit => true), target: '_blank'
      else
        toolbar.link '查看', main_app.company_path(instance, :locale => :en), target: '_blank'
      end
      
      # toolbar.edit if admin && admin.actions.include?(:edit)
      # toolbar.delete if admin && admin.actions.include?(:destroy)
    end
  end
  # Customize the table columns shown on the index view.
  #
  # table do
  #   column :name
  #   column :created_at, align: :center
  #   actions
  # end

  # Customize the form fields shown on the new/edit views.
  #
  form do |company|
    text_field :name
    text_field :name_en
    select :company_type, [['设计公司', :design], ['走秀企业', :clothing], ['供应链企业', :manufacture]]
    text_field :description
    text_field :description_en
    select :status, [['允许展示', :allow], ['禁止展示', :disabled]]
    select :recommended, [['首页推荐', :vip], ['首页不推荐', :normal]]
    file_field :logo
    number_field :slot
    select :company_classifies, CompanyClassify.pluck(:name, :id), {:selected => company.company_classifies.pluck(:id)}, multiple: true, include_blank: false
  end

  controller do
    def allow
      company = admin.find_instance(params)
      company.update(:status => :allow)
      flash[:message] = '已通过'
      redirect_to admin.path(:index)
    end
    def disable
      company = admin.find_instance(params)
      company.destroy
      flash[:error] = '已拒绝'

      redirect_to admin.path(:index)
    end
    def detail_allow
      company = admin.find_instance(params)
      company.company_audit.allow
      flash[:message] = '已通过'
      redirect_to admin.path(:index)
    end
    def detail_disable
      company = admin.find_instance(params)
      company.company_audit.reject
      flash[:error] = '已拒绝'
      redirect_to admin.path(:index)
    end
    def create_live
      company = admin.find_instance(params)
      Live.create(:company => company, :status => :closing, :live_type => company.company_type, :name => company.name)
      flash[:message] = '已开通'
      redirect_to admin.path(:index)
    end
    
  end

  routes do
    post :allow, on: :member
    post :disable, on: :member
    post :detail_allow, on: :member
    post :detail_disable, on: :member
    post :create_live, on: :member
  end
  # Customize the table columns shown on the index view.
  #
  # table do
  #   column :name
  #   column :created_at, align: :center
  #   actions
  # end

  # Customize the form fields shown on the new/edit views.
  #
  # form do |company|
  #   text_field :name
  #
  #   row do
  #     col { datetime_field :updated_at }
  #     col { datetime_field :created_at }
  #   end
  # end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  params do |params|
    params[:company][:company_classifies] = CompanyClassify.where(:id => params[:company][:company_classifies])
    # params.slice(*Trestle.config.persistent_params).permit(*Trestle.config.persistent_params)
    params.require(:company).permit!
  end
end
