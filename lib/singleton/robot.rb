require 'tjplurk/robot'

class Robot
  include Singleton

  def initialize
    @updated_at = Topic.maximum(:updated_at)
    @robot = Tjplurk::Robot.new Topic.where(subscriber: nil)
  end

  def respond input, plurk_uid: nil
    private_robot = nil
    if user = User.find_by(plurk_uid: plurk_uid)
      if topics = user.subscribed_topics.presence
        private_robot = Tjplurk::Robot.new topics
      end
    end

    maximum_updated_at = Topic.maximum(:updated_at)
    if @updated_at < maximum_updated_at
      @robot = Tjplurk::Robot.new Topic.where(subscriber: nil)
      @updated_at = maximum_updated_at
    end

    if private_robot
      order = [@robot, private_robot].shuffle!
      response = order.pop.respond(input) || order.pop.respond(input)
    else
      @robot.respond(input)
    end
  end
end