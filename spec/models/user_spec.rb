require 'rails_helper'

RSpec.describe User, type: :model do

  it 'is not valid without valid attributes' do
    expect(User.new).to be_invalid
  end

  it 'is not valid without an email' do
    expect(User.new(email: nil)).to be_invalid
  end
  it 'is not valid without a password_digest' do
    expect(User.new(password: nil)).to be_invalid
  end

  it 'is not valid without a password' do
    expect(User.new(password_digest: nil)).to be_invalid
  end
end
