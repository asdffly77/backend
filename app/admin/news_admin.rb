Trestle.resource(:news, :model => New) do
  menu do
    item '发布中心管理', icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  
  table do
    column :name
    column :name_en
    column :detail do |new_info|
      link_to '中文内容', main_app.edit_news_path(new_info, :locale => 'zh-CN')
    end
    column :detail_en do |new_info|
      link_to '英文内容', main_app.edit_news_path(new_info, :locale => 'en')
    end
    column :created_at, align: :center
    actions
  end

  form do |new_info|
    text_field :name
    text_field :name_en
    datetime_field :start_at
    datetime_field :end_at
    file_field :image

    number_field :slot
    
    select :new_type, [['普通新闻', 'normal'], ['推荐新闻', 'vip']]
    select :new_classify_id, NewClassify.all, {:selected => new_info.new_classify_id}, include_blank: false
    
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:new).permit(:name, ...)
  # end
end
