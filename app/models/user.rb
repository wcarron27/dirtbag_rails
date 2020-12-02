class User < ApplicationRecord
  has_secure_password

  has_many :bouldering_workouts

  validates :email, presence: true, uniqueness: true, confirmation: true
  validates :email_confirmation, presence: true, on: :create
  validates :tos, presence: true, acceptance: true, on: :create
  validates :gender, inclusion: { in: %w(male female trans other) }, allow_nil: true

  def admin?
    self.admin == true
  end

  def admin_or_owner?(object)
    return self.admin == true || object.user_id == self.id
  end
end
