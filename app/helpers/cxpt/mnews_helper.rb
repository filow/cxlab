module Cxpt::MnewsHelper
  def mnews_status_label(news)
    #信息在草稿箱中
    if news.is_draft
      tag=bs_label_tag('草稿','default')
      #信息未发布
    elsif news.publish_at < Time.now
      tag=bs_label_tag('已发布','success')
    elsif news.publish_at > Time.now
      tag=bs_label_tag('未发布','info')
    end
    tag
  end

  def mnews_cate_option(tree_obj)
    result = ''
    tree_obj.each do |p|
      result+=sprintf('<optgroup label="%s">',p.name)
      p.child.each do |c|
        type=c.display_text
        result+=sprintf('<option value="%d" data-subtext="%s">%s</option>',c.id,type,c.name)
      end
      result+='</optgroup>'
    end
    result.html_safe
  end
  def mnews_cate_option_with_all(tree_obj)
    result='<optgroup label="全选">' \
          +'<option value="0" data-subtext="">全选</option>' \
          +'</optgroup>'
    result+= mnews_cate_option(tree_obj)
    result.html_safe
  end
end
