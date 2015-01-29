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

    def self.holdings
        now = Date.today
        valid_competes = Manage::Compete.holdings.select(:id,:contest_id)
        self.where(id:valid_competes.collect{|x| x.id}).select(:id,:name,:summary,:cover).limit(4)
        # Manage::Compete.all
        # self.where()
    end

    def holding_sections
        valid_compete = Manage::Compete.holdings.find(id)
        valid_compete.sections.order(:start_time)
    end

    def next_section_with_list(section_list)
        ordered_list = section_list.sort_by{|sec| sec.start_time}
        now = DateTime.now
        ordered_list.each do |section|
            if section.start_time >= now
                return section
            end
        end
        return nil
    end
end
