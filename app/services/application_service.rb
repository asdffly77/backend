class ApplicationService
  #
  # @!attribute [ErrPack] err_pack
  #   @return [ErrPack] 返回错误信息
  attr_reader :err_pack

  #
  # 添加一个错误
  #
  # 使用 ErrItem Key 添加一个独立的错误，可以制定 `http_status_code`,
  #
  # 将会将 `keys` 找到的 ErrItem 添加进当前的 @err_pack 中
  #
  # 如果传入了 `http_status_code`，那么将会修改 `@err_pack` 的 `http_status_code`
  # 也就是说 `@err_pack` 中的 `http_status_code` 中最后一次 `add_item` 指定的状态码
  #
  # 未指定的话，默认状态码为 200
  #
  # @param [Array] *keys
  # @param [Integer] http_status_code: nil
  #
  # @return [void]
  #

  def add_error(*keys, http_status_code: 200, message: nil)
    if @err_pack.nil?
      @err_pack = ErrPack.new ErrItem.new(*keys, :message => message),
                              :http_status_code => http_status_code
    else
      @err_pack.add_error ErrItem.new(*keys, :message => message),
                          :http_status_code => http_status_code
    end
  end

  #
  # 将一个 ErrItem 直接添加到 @err_pack 中
  #
  # @param [ErrItem] item
  #
  # @return [ErrPack]
  #

  def add_error_item(item, http_status_code: 200)
    if @err_pack.nil?
      @err_pack = ErrPack.new(item, :http_status_code => http_status_code)
    else
      @err_pack.add_error(item, :http_status_code => http_status_code)
    end
  end
end
