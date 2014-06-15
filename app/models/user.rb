class User < ActiveRecord::Base
  has_many :topics
  has_many :subscribed_topics, class_name: :Topic, foreign_key: :subscriber_id

  def to_param
    nick_name
  end
end
