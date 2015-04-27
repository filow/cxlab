json.array!(@cxpt_mnews) do |cxpt_mnews|
  json.extract! cxpt_mnews, :id, :title, :content, :summary, :author, :publish_at, :view_count, :cxcate_id
  json.url cxpt_mnews_url(cxpt_mnews, format: :json)
end
