class Response < ActiveRecord::Base
  belongs_to :topic, touch: true
end
