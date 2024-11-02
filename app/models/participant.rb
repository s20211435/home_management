class Participant < ApplicationRecord
  belongs_to :user
  belongs_to :schedule

  validates :user_id, uniqueness: { scope: :schedule_id }
end
