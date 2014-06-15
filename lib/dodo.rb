api = Tjplurk::API.new

api.real_time do |plurk|
  api.request '/APP/Alerts/addAllAsFriends'
  next unless plurk['type'] == 'new_plurk'
  # content = plurk['content'].gsub(/<[^>]*>/, '')
  content = plurk['content_raw']

  if response = Robot.instance.respond(content, plurk_uid: plurk['user_id'].to_s)
    response_params = {
      plurk_id: plurk['plurk_id'],
      content: response,
      qualifier: ':'
    }
    api.request '/APP/Responses/responseAdd', response_params
  end
end