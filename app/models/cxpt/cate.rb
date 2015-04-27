class Cxpt::Cate < ActiveRecord::Base
  has_many :newses, :class_name => 'Cxpt::Mnews'
end
