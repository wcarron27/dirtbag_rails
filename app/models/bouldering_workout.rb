class BoulderingWorkout < ApplicationRecord
  belongs_to :user

  validates :start_time, :end_time, :location, presence: true

  def duration
    duration = (self.end_time.to_time - self.start_time.to_time) / 1.minute
    duration
  end
end
