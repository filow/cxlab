class Cfg

    def method_missing(name,*arg)
        name=name.to_s
        if config_obj=get_cached_data(name)
            val=config_obj.value
            return val
        else
            super
        end
    end

private
    # 获取缓存中的设置值，当缓存中不存在该值时会从Manage::Config中读取
    # key是设置的健，force_refresh为真时无论缓存是否存在都强制刷新
    def get_cached_data(key,force_refresh=false)
        @manage_config_cache ||= Cache.new("manage_config_cache")
        key=key.to_s
        @manage_config_cache.get(key,nil,force_refresh){ Manage::Config.find_by_key(key) }
    end


end