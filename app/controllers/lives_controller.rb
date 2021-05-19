class LivesController < ApplicationController
  before_action :authenticate!, :only => [:comment_create, :barrage_create]
  def index
    @page_id = 'livelist'
    @lives = Live.send(params[:classify]) if params[:classify].present? && %w(canton_fair activity design clothing manufacture).include?(params[:classify])
    redirect_to lives_path(:locale => I18n.locale, :classify => 'canton_fair') unless params[:classify].present?
  end

  def show
    @page_id = 'live'
    @life = Live.find(params[:id])
    @banners = Banner.live_show.where('start_at <= ? and end_at >= ?', Time.now, Time.now).where(:language => params[:locale] == 'en' ? [0, 1] : [0, 2])
  end

  def update
    @life = Live.find(params[:id])
    if @life.update(life_params)
      redirect_to lives_dashboard_index_path
      return
    end
    flash[:error] = @life.errors.full_messages
    redirect_to lives_dashboard_index_path
    return
  end

  def lives
    page = params[:page] || 1
    lives = Live.all.page(params[:page]).per(4)
    a = lives.map do |live|
      {
        :image => live.image.url,
        :name => live.name_i18n_show,
        :url => life_path(live, :locale => I18n.locale),
        :author => live.company&.name_i18n_show || live.author,
        :tag => nil
      }
    end
    render :json => a
  end

  def history
    @life = Live.find(params[:id])

    page = params[:page].to_i || 1
    service = TencentCloudService.new('AKIDZrwmMfTQO5UdUtscKnIV9W6i3ngKmqpZ', 'bw3uVRN6ZJM8etsgEm34tE5YdS4RZbQK')
    resp = service.get_live_history(@life.hashid, page - 1, 4)
    p resp
    a = resp["MediaInfoSet"].map do |video|
      {
        :image => video["BasicInfo"]["CoverUrl"],
        :name => @life.name_i18n_show,
        :url => video["BasicInfo"]["MediaUrl"],
        :author => @life.company&.name_i18n_show || @life.author,
        :tag => nil
      }
    end
    render :json => a
  end

  def cases
    @life = Live.find(params[:id])
    page = params[:page] || 1
    cases = @life.company&.cases
    
    if cases.present?
      a = cases.map do |case_info|
        {
          :image => case_info.images&.first&.image&.url,
          :name => case_info.name_i18n_show,
          :url => case_path(case_info, :locale => I18n.locale),
          :author => case_info.company&.name_i18n_show,
          :tag => nil
        }
      end
    else
      a = []
    end
    
    render :json => a
  end

  def guests
    page = params[:page] || 1
    @life = Live.find(params[:id])
    details = @life.live_details.page(params[:page]).per(4)
    a = details.map do |detail|
      {
        :image => detail.image.url,
        :name => detail.name_i18n_show,
        :url => detail.url,
        :author => detail.description_i18n_show,
        :tag => nil
      }
    end
    render :json => a
  end

  def comments
    page = params[:page] || 1
    @comments = Live.find(params[:id]).comments.page(page).per(10)
    a = @comments.map do |comment|
      {
        :avatar => comment.user.image&.url,
        :created_at => comment.created_at&.strftime("%Y-%m-%d %H:%M:%S"),
        :detail => comment.detail,
        :name => comment.user.email.split('@')[0]
      }
    end
    render :json => a
  end

  def comment_create
    @life = Live.find(params[:id])
    comment = @life.comments.create(:user => current_user, :detail => params[:detail])
    render :json => {
      :avatar => comment.user.image&.url,
      :created_at => comment.created_at&.strftime("%Y-%m-%d %H:%M:%S"),
      :detail => comment.detail,
      :name => comment.user.email.split('@')[0]
    }
  end


  def barrages
    @barrages = Live.find(params[:id]).barrages.where('created_at >= ?', Time.now - 1.minutes)
    a = @barrages.map do |barrage|
      {
        :id => barrage.id,
        :avatar => barrage.user.image&.url,
        :created_at => barrage.created_at&.strftime("%Y-%m-%d %H:%M:%S"),
        :detail => barrage.detail,
        :name => barrage.user.email.split('@')[0]
      }
    end
    render :json => a
  end

  def barrage_create
    @life = Live.find(params[:id])
    barrage = @life.barrages.create(:user => current_user, :detail => params[:detail])
    render :json => {
      :id => barrage.id,
      :avatar => barrage.user.image&.url,
      :created_at => barrage.created_at&.strftime("%Y-%m-%d %H:%M:%S"),
      :detail => barrage.detail,
      :name => barrage.user.email.split('@')[0]
    }
  end

  private
  def life_params
    params.require(:live).permit!
  end
end
