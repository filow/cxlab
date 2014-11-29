json.array!(@manage_news) do |manage_news|
  json.extract! manage_news, :id, :title, :author, :summary, :is_draft, :publish_at
  json.contest manage_news.contest
  json.url manage_news_url(manage_news)
end
