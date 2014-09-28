class Cache
    def initialize(prefix="",expire=3600)
        @store=Rails.cache
        @prefix=prefix
        @expire=expire
    end

    def method_missing(name,*arg)
        if name =~ /=$/
            @store.write(full_key(name),arg[0][0],expires_in: expires(arg[0][1]))
        else
            @store.read(full_key(name))
        end
    end

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

    def has?(name)
        @store.exist?(full_key(name))
    end

    def get(name,expire=nil,force_refresh=false,&block)
        if @store.exist?(full_key(name)) && !force_refresh
            @store.read(full_key(name))
        else
            val=yield
            expire=@expire if expire.nil?
            @store.write(full_key(name),val,expires_in: expires(expire)) unless val.nil?
            val
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