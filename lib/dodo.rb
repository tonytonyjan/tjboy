require 'tjplurk/robot'

api = Tjplurk::API.new
updated_at = Topic.maximum(:updated_at)
robot = Tjplurk::Robot.new Topic.where(subscriber: nil)

api.real_time do |plurk|
  jj plurk
  api.request '/APP/Alerts/addAllAsFriends'
  next unless plurk['type'] == 'new_plurk'

  content = plurk['content'].gsub(/<[^>]*>/, '')

  maximum_updated_at = Topic.maximum(:updated_at)
  private_robot = nil
  if user = User.find_by(plurk_uid: plurk['user_id'].to_s)
    if topics = user.subscribed_topics.presence
      private_robot = Tjplurk::Robot.new topics
    end
  end

  if updated_at < maximum_updated_at
    robot = Tjplurk::Robot.new Topic.where(subscriber: nil)
    updated_at = maximum_updated_at
  end
  order = [robot, private_robot].shuffle!
  if response = order.pop.respond(content).presence || order.pop.respond(content).presence
    response_params = {
      plurk_id: plurk['plurk_id'],
      content: response,
      qualifier: ':'
    }

    api.request '/APP/Responses/responseAdd', response_params
  end
end