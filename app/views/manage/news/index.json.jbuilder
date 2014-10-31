json.array!(@manage_news) do |manage_news|
  json.extract! manage_news, :id, :title, :author, :content, :pure_content, :is_draft, :publish_at
  json.url manage_news_url(manage_news, format: :json)
end
