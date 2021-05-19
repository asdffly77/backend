class DashboardController < ApplicationController
  before_action :authenticate!
  before_action :set_company
  skip_before_action :verify_authenticity_token, :only => [:avatar]

  def index
    @page_id = 'dashboardUser'
  end

  def password
    @page_id = 'dashboardChangePassword'
  end

  def company
    redirect_to dashboard_index_path if @company&.user != current_user
    @page_id = 'dashboardCompany'
    @audit = CompanyAudit.find_by(:company => @company)
    @require_image = !@company.logo.present? rescue nil
  end

  def cases
    @page_id = 'dashboardCaseList'
    @cases = @company.cases
  end

  def cases_edit
    @page_id = 'dashboardCompany'
    @case = Case.find(params[:id])
  end

  def cases_create
    @page_id = 'dashboardCompany'
    @case = Case.new
  end

  def lives
    @page_id = 'dashboardCompany'
    @life = current_user.company.live
  end
  
  def demands
    @page_id = 'dashboardCaseList'
    @demands = Demand.all
  end

  def demand_show
    @page_id = 'dashboardCompany'
    @demand = Demand.find(params[:id])
    @demand.viewers << current_user.company rescue nil
  end

  def avatar
    current_user.update(:image => params[:upload])
    render json: {
      url: current_user.image.url
    }
  end

  def change_password
    
    if current_user.authenticate(params[:recover_password][:old_password])
      current_user&.update(:password => params[:recover_password][:password])
      session[:user_id] = nil
      redirect_to new_session_path    
    else
      flash[:error] = params[:locale] == 'en' ? 'Old password wrong.' : '密码错误，请重试'
      redirect_to password_dashboard_index_path    
    end
    
  end

  def translate
    @page_id = 'dashboardUser'
    
  end

  def user_demands
    @page_id = 'dashboardCaseList'
    @demands = current_user.demands
  end
  
  private
  def set_company
    @company = current_user.company
  end
  
  def create_lock
    AtField::Lock.new(:name => 'recover_password', :scope => current_user.email, :expiry => 60)
  end
  
end
