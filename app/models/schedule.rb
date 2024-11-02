class Schedule < ApplicationRecord
  belongs_to :user
  has_many :participants
  has_many :attendees, through: :participants, source: :user

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end
