class Cxpt::Cate < ActiveRecord::Base
  has_many :newses, :class_name => 'Cxpt::Mnews'

  def self.all_cates
    [["未分类", nil]]+select("name,id").collect{|r|[r.name,r.id]}
  end
end
