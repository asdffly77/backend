Trestle.resource(:friend_links) do
  menu do
    item '友情链接', icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :image do |banner|
      image_tag banner.image&.url.presence || '', style: 'max-height: 100px'
    end

    column :url

    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  form do |friend_link|
    file_field :image
    url_field :url
  end

  # By default, all parameters passed to the update and create actions will be
  # permitted. If you do not have full trust in your users, you should explicitly
  # define the list of permitted parameters.
  #
  # For further information, see the Rails documentation on Strong Parameters:
  #   http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # params do |params|
  #   params.require(:friend_link).permit(:name, ...)
  # end
end
