module Trestle
  module Auth
    class Configuration

      option :login_url, -> { Rails.application.routes.url_helpers.login_path }, evaluate: false

      option :redirect_on_login, -> { Trestle.config.path }, evaluate: false
      option :redirect_on_logout, -> { Rails.application.routes.url_helpers.login_path }, evaluate: false

    end
  end
end
