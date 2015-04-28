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
end
