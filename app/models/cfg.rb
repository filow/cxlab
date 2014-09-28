class Cfg

    def method_missing(name,*arg)
        name=name.to_s
        if config_obj=get_cached_data(name)
            # 如果找到了这个值
            val=config_obj.value
            return val
        else
            # 如果没有找到，就按照原来的路径报方法未找到错误
            super
        end
    end

private
    # 获取缓存中的设置值，当缓存中不存在该值时会从Manage::Config中读取
    # key是设置的健，force_refresh为真时无论缓存是否存在都强制刷新
    def get_cached_data(key,force_refresh=false)
        # 如果变量还没有被设置过就初始化一个Cache类
        @manage_config_cache ||= Cache.new("manage_config_cache")
        key=key.to_s
        @manage_config_cache.get(key,nil,force_refresh){ Manage::Config.find_by_key(key) }
    end


end