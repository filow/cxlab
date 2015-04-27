class Cxpt::Mnews < ActiveRecord::Base
  self.table_name = "cxpt_news"
  belongs_to :cate, :class_name => 'Cxpt::Cate'
end
