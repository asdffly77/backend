#
# 冷却
#
# @author hging <hging3@gmail.com>
#
module AtField
  class Lock
    class Timeout < StandardError; end

    #
    # 初始化一个 AtField
    #
    # @param [Any] scope 这个控制领域的 scope，一般使用需要限制的当前对象。
    #                    比如需要限制当前用户的发文章频率，那么这里就需要传当前用户
    # @param [String/Symbol] name 这个控制域的名字，同样的 scope 不同 name 的控制领域是不同的
    # @param [Integer] expiry 控制领域的过期时间，单位是秒
    #
    def initialize(name:, scope:, expiry:)
      @name       = name.underscore.underscore.gsub("\s", "_")
      @scope      = scope.is_a?(String) ? scope.underscore.underscore.gsub("\s", "_") : to_scope_identity(scope)
      @expiry   = expiry
    end


    #
    # 尝试获取锁
    #
    # 如果获取到了，返回 true，否则返回 false
    #
    # @return [Boolean]
    #
    def get
      redis_pool.set(pool_key, 1, {:ex => @expiry, :nx => true})
    end

    #
    # 检查锁是否存在
    #
    # 重要: 只能用于展示，并不能当作已经获取到了锁
    #
    # @return [Boolean]
    #
    def locking?
      redis_pool.exists(pool_key)
    end
    alias_method :exists?, :locking?

    #
    # 删除锁
    #
    # 如果删除成功，返回 1，否则返回 0
    #
    # @return [Boolean]
    #
    def release
      redis_pool.del(pool_key)
    end

    #
    # 返回当前 AtField 控制的 redis set 的 key
    #
    #
    # @return [String]
    #
    def pool_key
      "at-lk:#{@scope}:#{@name}"
    end

    #
    # 生成一个非 String 类型的对象的 identity
    #
    # @param [Any] obj
    #
    # @return [String]
    #
    def to_scope_identity(obj)
      r = obj.class.to_s.underscore
      r = "#{r}:#{obj.id}" if obj.respond_to?(:id)
      r
    end

    #
    # 返回使用的 Redis 连接池
    #
    #
    # @return [ConnectionPool]
    #
    def redis_pool
      Rails.env.development? ? Redis.new(url: "redis://127.0.0.1:6379") : Redis.new(url: "redis://root:a76TQ!t7vm@172.16.16.13:6379/0")
    end
  end
end