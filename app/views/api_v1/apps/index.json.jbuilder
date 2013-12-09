json.apps do |json|
  json.array! @apps do |app|
    json.partial! "resource", app: app
  end
end
