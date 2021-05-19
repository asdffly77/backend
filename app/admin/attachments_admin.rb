Trestle.resource(:attachments) do
  menu do
    item '附件管理', icon: "fa fa-star"
  end
  build_instance do |attrs, params|
    scope = params[:live_id] ? Live.find(params[:live_id]).attachments : Attachment
    scope.new(attrs)
  end

  form do |attachment|
    file_field :file
    collection_select :live_id, Live.all, :id, :name, label: '直播'
  end

  # collection_select :name, Color.all, :code, :name_with_code, label: "Collection"
  # Customize the table columns shown on the index view.
  #
  table do
    column :id
    column :file do |a|
      link_to '下载链接', a.file.url
    end
    column :name
    column :name_en

    column :live, :link => true
    # column :created_at, align: :center
    actions
  end

  # Customize the form fields shown on the new/edit views.
  #
  # form do |attachment|
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
  #   params.require(:attachment).permit(:name, ...)
  # end
end
