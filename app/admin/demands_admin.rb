Trestle.resource(:demands) do
  menu do
    item "需求管理", icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  #
  # table do
  #   column :name
  #   column :created_at, align: :center
  #   actions
  # end

  form do |user|
    text_field :company_name
    text_field :contract_name
    text_field :contract_phone_number
    text_field :contract_email
    text_field :contract_address
    text_field :detail

    number_field :slot
  end


  # Customize the form fields shown on the new/edit views.
  #
  # form do |demand|
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
  #   params.require(:demand).permit(:name, ...)
  # end
end
