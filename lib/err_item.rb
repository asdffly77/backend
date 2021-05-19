class ErrItem < StandardError
  attr_reader :code, :message, :keys

  def initialize(*args, message: nil, i18n: {locale: 'zh-TW'}, data: nil)
    @keys    = args.map(&:to_s)
    @code    = I18n.t("err_item.#{@keys.join('.')}.code")
    p i18n
    @message = message || I18n.t("err_item.#{@keys.join('.')}.message", i18n)
    @data = data

    unless @code.present? && @message.present?
      raise ArgumentError, "error keys not found #{@keys}"
    end
  end

  #
  # 修改当前 ErrItem 实例的 message 文本
  #
  # @param [String] msg
  #
  # @return [void]
  #
  def message=(msg)
    @message = msg
  end

  def [](key)
    public_send(key.to_sym)
  end

  def to_h
    hash = { :code => code, :message => message }
    hash[:data] = @data if @data.present?
    hash
  end

  def to_json
    to_h.to_json
  end
end
