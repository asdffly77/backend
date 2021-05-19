require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PdcBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', 'err_item', '*.{yml}')]
    config.i18n.available_locales = ['en', 'zh-CN']
    config.autoload_paths += %W(#{config.root}/lib)
    config.eager_load_paths += %W(#{config.root}/lib)
    config.i18n.default_locale = 'zh-CN'
    # Don't generate system test files.
    config.generators.system_tests = nil
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address:              'smtpdm.aliyun.com',
      port:                 "25",
      domain:               'pdconline.org.cn',
      user_name:           'no-reply@pdconline.org.cn',
      password:             '89hRNxgRaM',
      authentication:       :plain,
    }
    config.cache_store = :redis_cache_store, { url: "redis://root:a76TQ!t7vm@172.16.16.13:6379/1" }
  end
end
