json.array!(@apps) do |app|
  json.extract! app, :id, :o_site_id, :o_user_id, :slug, :name, :owner, :pagetype, :uv, :punish, :keywords, :found_at, :site_type, :description, :logo
  json.url app_url(app, format: :json)
end
