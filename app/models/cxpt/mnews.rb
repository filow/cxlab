class Cxpt::Mnews < ActiveRecord::Base
  self.table_name = "cxpt_news"
  belongs_to :cate, :class_name => 'Cxpt::Cate'
  validates_length_of :title,minimum: 5
  validates_length_of :content,minimum: 20,maximum: 60000

  before_save :set_summary_and_pure_content

  def set_summary_and_pure_content
    self.summary=self.content.gsub(/<\/?.*?>/,'').gsub(/&\w+;/,' ').gsub(/\s+/,' ')
  end


  def self.published
    self.where('publish_at < ?',Time.now).where(is_draft: false).order(publish_at: :desc)
  end

  def cate_name
    if cxpt_cate_id
      name=Cxpt::Cate.find(cxpt_cate_id).name
    else
      name="未分类"
    end
    name
  end

end
