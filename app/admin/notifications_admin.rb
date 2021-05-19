Trestle.resource(:notifications) do
  menu do
    item "跑马灯管理", icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :body
    column :is_active do |notification|
      case notification.is_active
      when true
        '已生效'
      when false
        '未生效'
      end
    end
    column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |notification|
    text_field :body
    select :is_active, [['生效', true], ['不生效', false]]
  
    row do
    end
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:notification).permit(:name, ...)
  # end
end
