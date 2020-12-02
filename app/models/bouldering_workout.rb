class BoulderingWorkout < ApplicationRecord
  belongs_to :user

  validates :start_time, :end_time, :location, presence: true
end
