class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  def err_pack
    return if errors.blank?

    err_items = errors.full_messages.map do |message|
      ErrItem.new(model_name.singular, "validation", :message => message)
    end

    ErrPack.new(*err_items, :http_status_code => 200)
  end
  
  def method_missing(method, *args)
    if method.to_s =~ /_i18n_show/
      I18n.locale == :en ? self.send(method.to_s.split('_')[0] + '_en') : self.send(method.to_s.split('_')[0])
    end
  end

  def self.method_missing(method, *args)
    p 234
    if method.to_s =~ /_select_field/
      method_name = method.to_s.split("_select_field")[0]
      self.send( method_name + 's').keys.map do |key|
        [I18n.t("#{self.to_s.downcase}.#{method_name}.#{key}"), key]
      end
    end
  end
  
end
