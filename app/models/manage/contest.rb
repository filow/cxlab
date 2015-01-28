class Manage::Contest < ActiveRecord::Base
    mount_uploader :cover, CoverUploader
    validates_presence_of :cover
    validates_inclusion_of :level,in: %w(校级 市级 省级 国家级 国际级 其他),allow_blank: true
    validates_length_of :name, in:2..15 , message: "应当至少2字最多15字"
    validates_length_of :summary, maximum: 200

    # 管理员会建立竞赛
    belongs_to :admin
    has_many :competes

    def self.contest_levels
        %w(校级 市级 省级 国家级 国际级 其他)
    end
end
