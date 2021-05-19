class ErrPack
  attr_reader   :err_items
  attr_accessor :http_status_code

  def initialize(*err_items, http_status_code: nil)
    @err_items        = err_items
    @http_status_code = http_status_code
  end

  def add_error(err_item, http_status_code: nil)
    @err_items << err_item
    @http_status_code = http_status_code if !http_status_code.nil?
  end

  #
  # 将一个 ErrItem 放置在 ErrPack 错误的第一个位置
  #
  # @param [ErrItem] err_item
  # @param [Integer] http_status_code
  #
  # @return [void]
  #
  def prepend_error(err_item, http_status_code: nil)
    @err_items.unshift(err_item)
    @http_status_code = http_status_code if !http_status_code.nil?
  end

  def error_messages
    @err_items.map { |item| item.message }
  end
end
