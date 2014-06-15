class Topic < ActiveRecord::Base
  scope :subscribed_by, ->(user){ where(subscriber: user) }

  belongs_to :user
  belongs_to :subscriber, class_name: :User
  has_many :responses
  accepts_nested_attributes_for :responses, allow_destroy: true, reject_if: :all_blank
end
