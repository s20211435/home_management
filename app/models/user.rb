class User < ApplicationRecord
    has_secure_password
    has_many :schedules
    has_many :participants
    has_many :participated_schedules, through: :participants, source: :schedule

    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
end
