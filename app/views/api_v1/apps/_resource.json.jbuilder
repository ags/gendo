json.(app,
  :id,
  :name,
  :slug,
)

if app.current_access_token.present?
  json.access_token app.current_access_token.token
end
