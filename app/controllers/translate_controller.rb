class TranslateController < ApplicationController
  before_action :authenticate!
  # layout false
  def index
    @page_id = 'dashboardCompany'
  end
end
