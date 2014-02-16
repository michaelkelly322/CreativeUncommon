json.array!(@works) do |work|
  json.extract! work, :id, :blurb, :title, :author_name, :body, :mature, :draft
  json.url work_url(work, format: :json)
end
