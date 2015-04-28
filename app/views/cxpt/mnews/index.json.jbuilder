json.array!(@cxpt_mnews) do |cxpt_mnews|
  json.extract! cxpt_mnews, :id, :title, :summary, :author, :publish_at, :view_count,:is_draft
  json.cate cxpt_mnews.cate_name
  json.url cxpt_mnews_url(cxpt_mnews)
end
