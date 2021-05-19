Trestle.resource(:lives, model: Live) do
  
  menu do
    item '直播管理', icon: "fa fa-star"
  end

  # Customize the table columns shown on the index view.
  #
  table do
    column :name
    column :name_en
    column :rtmp_live_address, truncate: false
    column :company, :link => true
    column :live_type do |live|
      case live.live_type
      when 'canton_fair'
        '广交会直播'
      when 'activity'
        '设计活动直播'
      when 'design'
        '设计公司直播'
      when 'clothing'
        '走秀企业直播'        
      end
    end
    column :source do |live|
      case live.source
      when 'streaming'
        '直播'
      when 'video'
        '录播'
      end
    end
    column :slot
    # column :created_at, align: :center
    actions
  end
  form do |live|
    tab '直播' do
      text_field :name
      text_field :name_en
      select :live_type, [['广交会直播', :canton_fair], ['设计活动直播', :activity], ['设计公司直播', :design], ['走秀企业直播', :clothing]]
      select :source, [['直播', 'streaming'], ['录播', 'video']]
      select :ad_show, [['显示广告', true], ['不显示广告', false]]
      text_field :source_url

      text_field :description

      file_field :image
      file_field :logo
      text_field :author
      number_field :slot
    end
    tab '附件', badge: live.attachments.size do
      # table live.attachments, admin: :attachment do
      #   column :file, link: true
      #   column :created_at, align: :center
      #   actions
      # end
      table live.attachments, admin: :attachments do
        column :id
        column :file do |a|
          link_to '下载链接', a.file.url
        end
        column :live, :link => true
        # column :created_at, align: :center
        actions
      end

      concat admin_link_to("添加附件", admin: :attachments, action: :new, params: { live_id: live }, class: "btn btn-success")
    end
    tab '直播信息管理（嘉宾列表、联系企业）', badge: live.live_details.size do
      table live.live_details, admin: :live_details do
        column :id
        column :image do |a|
          link_to '下载链接', a.image.url
        end
        column :name
        column :name_en
        column :url, :link => true
        actions

      end
    end
    concat admin_link_to("添加信息", admin: :live_details, action: :new, params: { live_id: live }, class: "btn btn-success")

  end

  # Customize the form fields shown on the new/edit views.
  #
  # form do |live|
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
  #   params.require(:live).permit(:name, ...)
  # end
end
