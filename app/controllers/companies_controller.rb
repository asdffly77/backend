class CompaniesController < ApplicationController
  before_action :set_company, :only => %w(show update edit)
  before_action :authenticate!, :only => %w(edit)
  # autocomplete :company_classify, :name, :display_value => :name_i18n_show

  def index
    @page_id = 'companyList'
    @banners = Banner.companies.where('start_at <= ? and end_at >= ?', Time.now, Time.now).where(:language => params[:locale] == 'en' ? [0, 1] : [0, 2])
    @company_classifies = CompanyClassify.design
    @companies = params[:company_classify_id].present? ? Company.joins(:company_classify_relations).where('company_classify_relations.company_classify_id = ?', params[:company_classify_id]).design.allow.human_order : Company.design.allow.human_order
  end

  def manufacture
    @page_id = 'manufacture'
    @banners = Banner.companies.where('start_at <= ? and end_at >= ?', Time.now, Time.now).where(:language => params[:locale] == 'en' ? [0, 1] : [0, 2])
    @company_classifies = CompanyClassify.manufacture
    @companies = params[:company_classify_id].present? ? Company.joins(:company_classify_relations).where('company_classify_relations.company_classify_id = ?', params[:company_classify_id]).manufacture.allow.human_order : Company.manufacture.allow.human_order
  end

  def show
    @page_id = 'company'
    @company = @company.company_audit if params[:audit]
  end
  
  def edit
    redirect_to dashboard_index_path if @company.user != current_user
    @page_id = 'editor'
    @detail = CompanyAudit.find_by(:company_id => params[:id])&.detail_i18n_show || @company.detail_i18n_show
  end

  def update
    if company_params[:detail].present? || company_params[:detail_en].present? || company_params[:description].present? || company_params[:description_en].present? || company_params[:name].present? || company_params[:name_en].present?
      @company.update(:logo => company_params[:logo]) if company_params[:logo].present?
      classifies = CompanyClassify.where(:id => company_params[:company_classifies])
      @company.update(:company_classifies => classifies)
      @audit = @company.company_audit
      @audit.update(company_params.except('logo', 'company_classifies'))
      @audit.allow # 六月一号之前不审核
    else
      @company.update(company_params)
    end
    redirect_to company_dashboard_index_path
  end

  def create
    company = Company.find_or_initialize_by(:user => current_user)
    company.state = :disabled
    company.recommended = :normal
    company.attributes = company_params
    if company.save
      redirect_to dashboard_index_path    
    else
      flash[:error] = I18n.t('company_repeated')
      redirect_to dashboard_index_path    
    end
  end
  
  
  private

  def company_params
    params.delete('_method')
    params.require('company').except('_method', 'authenticity_token').permit!
  end

  def set_company
    @company = Company.find params[:id]
  end
end
