class Cxpt::Cate < ActiveRecord::Base
  has_many :newses, :class_name => 'Cxpt::Mnews'
  has_many :children,class_name: 'Cxpt::Cate',foreign_key: "pid"
  belongs_to :parent, class_name: 'Cxpt::Cate',foreign_key: "pid"

  def self.all_cates
    [["未分类", nil]]+select("name,id").collect{|r|[r.name,r.id]}
  end

  # 输出树形的cate列表
  def self.tree_view
    cache = Cache.new('cxpt')
    # c = cache[:cate_tree_cache]
    # return c if c

    result = []
    parent = self.select(:id,:name,:display).where('pid=0').all
    parent.each do |x|
      tmp = {name: x.name , display: x.display, id: x.id, child: []}
      x.child = x.children.select(:id,:name,:display).load
      result << x
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

  def display_text
    rule = {
        :image   => '图片新闻',
        :list    => '文字新闻',
        :passage => '文章页',
        :gallery => '展示页面'
    }
    rule[display.to_sym]
  end
end
