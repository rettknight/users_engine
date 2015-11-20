json.array!(@usertypes) do |usertype|
  json.extract! usertype, :id
  json.url usertype_url(usertype, format: :json)
end
