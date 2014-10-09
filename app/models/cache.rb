class Cache
    def initialize(prefix="",expire=3600)
        @store=Rails.cache
        @prefix=prefix
        @expire=expire
    end

    # 从缓存中读取
    def [](name)
        @store.read(full_key(name))
    end

    # 使用t[key]=value  或者  t[key,expire]=value 调用
    def []=(name,expire=nil,value)
        unless value.nil?
            @store.write(full_key(name),value,expires_in: expires(expire))
        else
            @store.delete(full_key(name))
        end
    end

    # 测试健是否存在
    def has?(name)
        @store.exist?(full_key(name))
    end

    # 在get函数后跟上一个block，那么函数将会缓存block的返回值，以供以后的调用。
    # 但是请注意，不要直接把数据库的请求语句放进来，因为这会保存其引用而不是值，这样每次调用缓存时仍然会请求数据库
    def get(name,expire=nil,force_refresh=false,&block)
        if @store.exist?(full_key(name)) && !force_refresh
            @store.read(full_key(name))
        else
            val=yield

            # 除非值是一个nil，否则就写入缓存
            @store.write(full_key(name),val,expires_in: expires(expire)) unless val.nil?

            return val
        end
    end


private
    def full_key(name)
        @prefix+name.to_s
    end
    def expires(expire)
        if expire.nil?
            @expire
        else
            expire
        end
    end
end