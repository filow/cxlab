class Cache
    def initialize(prefix="",expire=3600)
        @store=Rails.cache
        @prefix=prefix
        @expire=expire
    end

    def [](name)
        @store.read(full_key(name))
    end

    def []=(name,value,expire=nil)
        unless value.nil?
            @store.write(full_key(name),value,expires_in: expires(expire))
        else
            @store.delete(full_key(name))
        end
    end

    def has?(name)
        @store.exist?(full_key(name))
    end

    def get(name,expire=nil,&block)
        if @store.exist?(full_key(name))
            @store.read(full_key(name))
        else
            val=yield
            expire=@expire if expire.nil?
            @store.write(full_key(name),val,expires_in: expires(expire))
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