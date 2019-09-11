require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build :random_user }

  it 'user is valid?' do
    expect(build(:user)).to be_valid
  end

  it 'user needs to have a name to be valid' do
    user.name = nil
    expect(user).to_not be_valid
  end
end
