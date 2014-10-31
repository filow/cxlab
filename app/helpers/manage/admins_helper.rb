module Manage::AdminsHelper
    def tm(str)
        t("activerecord.attributes.manage/#{str}")
    end
    def tmc(str)
        ctl=params[:controller]
        t("activerecord.attributes.#{ctl[0,ctl.length-1]}.#{str.downcase}")
    end
end
