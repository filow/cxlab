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

    def color
        # 获取文件名
        filename = cover.file.identifier
        pos = filename.index('.')
        from = pos-6
        # 返回以#开头的6位颜色hex
        '#'+filename[from..pos-1]
    end


    def holding_compete
      now = Time.now.strftime('%Y-%m-%d')
      competes.where('start_time <= ? and end_time >= ?',now,now)
    end

end
