class User < ApplicationRecord
  has_secure_password

  has_many :bouldering_workouts
  validates :email, presence: true

  def admin?
    self.admin == 10
  end
end
