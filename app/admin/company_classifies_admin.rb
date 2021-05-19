Trestle.resource(:company_classifies) do
  menu do
    item '公司分类', icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :name
    column :name_en
    column :classify_type do |classify|
      case classify.classify_type
      when 'design'
        '设计公司'
      when 'clothing'
        '走秀企业'
      when 'for_search'
        '二级分类'
      when 'manufacture'
        '供应链企业'
      end
    end
    # actions
  end

  # Customize the form fields shown on the new/edit views.
  
  form do |company_classify|
    text_field :name
    text_field :name_en
    select :classify_type, [['设计公司', :design], ['供应链企业', :manufacture], ['走秀企业', :clothing], ['二级分类', :for_search]]
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:company_classify).permit(:name, ...)
  # end
end
