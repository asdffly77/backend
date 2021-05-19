Trestle.resource(:events) do
  menu do
    item '时间轴', icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :event_type do |event|
      case event.event_type
      when 'design'
        '设计活动'
      when 'fashion'
        '广交会时尚周'
      end
    end
    column :title
    column :url
    column :time
    column :tags

    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |event|
    text_field :title
    select :event_type, [['广交会时尚周', :fashion], ['设计活动', :design]]

    text_field :url
    text_field :time
    text_field :tags
    number_field :slot
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:event).permit(:name, ...)
  # end
end
