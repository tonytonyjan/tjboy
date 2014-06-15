class User < ActiveRecord::Base
  has_many :topics, dependent: :destroy
  has_many :subscribed_topics, class_name: :Topic, foreign_key: :subscriber_id, dependent: :destroy

  def to_param
    nick_name
  end

  def api
    @api ||= Tjplurk::API.new Settings.consumer_key, Settings.consumer_secret, token, secret
  end

  def own_topic? topic
    Settings.admin_nick_names.include? nick_name || topic.user == self || topic.subscriber == self
  end
end
