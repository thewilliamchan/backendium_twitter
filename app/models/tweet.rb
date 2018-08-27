class Tweet < ApplicationRecord
  validates :user_id, presence: true
  validates :message, presence: true, length: { maximum: 140 }

  belongs_to :user
end
