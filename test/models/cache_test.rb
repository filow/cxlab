require 'test_helper'

class CacheTest < ActiveSupport::TestCase
    setup do
        @cache = Cache.new
    end
    test "常量键值测试" do 
        keys = ["bgeg","1sfwef",":`123",:deaf,:qwc,1,12.11]

        keys.each do |key|
            @cache[key] = key
        end

        keys.each do |key|
            assert @cache[key]==key,"常量键值测试失败：#{key}"
        end
    end

    test "同值对象键测试" do
        # 同值对象键测试,仅限to_s值相等的对象
        @cache[Time.at(12345)]="12345"
        assert @cache[Time.at(12345)]=="12345","同值对象键测试失败：Time.at"

        @cache[Math.sqrt(2)]="12345"
        assert @cache[Math.sqrt(2)]=="12345","同值对象键测试失败：Cache.new"
    end

    test "过期时间测试" do 
        @cache[:test_time,3] = 12345
        assert @cache[:test_time] == 12345
        puts "[过期时间测试]停顿3秒钟"
        sleep 3
        assert_nil @cache[:test_time]

        # 测试立即失效
        @cache[:test_time,0] = 12345
        assert_nil @cache[:test_time]

        # 测试负值
        @cache[:test_time,-5] = 12345
        assert_nil @cache[:test_time]
    end
end
