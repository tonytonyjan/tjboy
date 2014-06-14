require 'tjplurk/robot'

api = Tjplurk::API.new
updated_at = Topic.maximum(:updated_at)
robot = Tjplurk::Robot.new Topic.all

api.real_time do |plurk|
  next unless plurk['type'] == 'new_plurk'

  content = plurk['content'].gsub(/<[^>]*>/, '')

  maximum_updated_at = Topic.maximum(:updated_at)  
  if updated_at < maximum_updated_at
    robot = Tjplurk::Robot.new Topic.all
    updated_at = maximum_updated_at
  end

  if response = robot.respond(content).presence
    response_params = {
      plurk_id: plurk['plurk_id'],
      content: response,
      qualifier: ':'
    }

    api.request '/APP/Responses/responseAdd', response_params
  end
end