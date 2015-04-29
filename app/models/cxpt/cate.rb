class Cxpt::Cate < ActiveRecord::Base
  has_many :newses, :class_name => 'Cxpt::Mnews'

  def self.all_cates
    [["未分类", nil]]+select("name,id").collect{|r|[r.name,r.id]}
  end

  # 输出树形的cate列表
  def self.tree_view
    cache = Cache.new('cxpt')
    c = cache[:cate_tree_cache]
    return c if c

    result = []
    parent = self.select(:id,:name,:display).where('pid=0').all
    parent.each do |x|
      tmp = {name: x.name , display: x.display, id: x.id, child: []}
      self.where('pid=?',x.id).select(:id,:name,:display).each do |child|
        tmp[:child] << {name: child.name, display: child.display, id: child.id}
      end
      result << tmp
    end
    cache[:cate_tree_cache] = result
    result
  end

  def child=(obj)
    @child = obj
  end
  def child
    @child || []
  end
end
