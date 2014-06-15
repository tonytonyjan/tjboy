class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :responses
  accepts_nested_attributes_for :responses, allow_destroy: true, reject_if: :all_blank
end
