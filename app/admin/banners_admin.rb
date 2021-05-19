Trestle.resource(:banners) do
  menu do
    item '广告位管理', banners_admin_index_path(:scope => '首页顶部图'), icon: "fa fa-star"
  end

  scopes do
    scope '首页顶部图(1440px*300px)', -> {Banner.home}, default: :true
    scope '首页推荐公司(600px*464px)', -> {Banner.home_company}
    scope '首页推荐直播(1200px*500px)', -> {Banner.home_live}
    scope '设计展示顶部图(1440px*300px)', -> {Banner.companies}
    scope '广交会时尚周顶部图(1440px*300px)', -> {Banner.function_week}
    scope '设计活动顶部图(1440px*300px)', -> {Banner.activity}
    scope '首页时尚周下面轮播图(1200px*500px)', -> {Banner.home_function_week}
    scope '首页时尚周推荐公司(600px*464px)', -> {Banner.home_function_week_company}
    scope '关于我们页面顶部图(1440px*300px)', -> {Banner.about}
    scope '直播详情页面顶部图(1440px*300px)', -> {Banner.live_show}
  end

  form do |banner|
    resource_types = [
      ['首页顶部图(1440px*300px)', :home],
      ['首页推荐公司(600px*464px)', :home_company],
      ['首页推荐直播(1200px*500px)', :home_live],
      ['设计展示顶部图(1440px*300px)', :companies],
      ['广交会时尚周顶部图(1440px*300px)', :function_week],
      ['设计活动顶部图(1440px*300px)', :activity],
      ['首页时尚周下面轮播图(1200px*500px)', :home_function_week],
      ['首页时尚周推荐公司(600px*464px)', :home_function_week_company],
      ['关于我们页面顶部图(1440px*300px)', :about],
      ['直播详情页面顶部图(1440px*300px)', :live_show],
    ]
    select :banner_type, resource_types
    select :language, [
      ['全部展示', :all_lang],
      ['仅英文展示', :en],
      ['仅中文展示', :cn]
    ]
    
    file_field :image
    date_field :start_at
    date_field :end_at
    url_field :url
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :image do |banner|
      image_tag banner.image.url, style: 'max-height: 100px' if banner.image.present?
    end
    column :start_at
    column :end_at

    column :url
    column :language  do |banner|
      case banner.language
      when 'all_lang'
        '全部展示'
      when 'en'
        '仅英文展示'
      when 'cn'
        '仅中文展示'
      end
    end
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  # form do |banner|
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
  # params do |params|
  #   params.require(:banner).permit(:name, ...)
  # end
end
