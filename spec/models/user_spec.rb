# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:harry) {User.create(username: 'harry', password: 'abcdef')}

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it {should validate_length_of(:password).is_at_least(6)}

  it { should validate_uniqueness_of(:username) }
  describe 'session token' do
    it 'assigns a session_token if one is not given' do
      expect(harry.session_token).not_to be_nil
    end
  end

describe '::find_by_credentials' do
  it 'returns right user with the right credentials' do
    User.create(username: 'user',password: 'password')
    user1 = User.find_by(username: 'user')
    user2 = User.find_by_credentials('user','password')
    expect(user1).to eq(user2)
  end

  it 'returns nil with incorrect credentials' do
    User.create(username: 'user',password: 'password')
    user1 = User.find_by(username: 'user')
    user2 = User.find_by_credentials('user','1243456')
    expect(user1).not_to eq(user2)
  end
end

describe '#ensure_session_token' do
  it 'assigns random session token if not given' do
    user = User.new(username: 'user',password: 'password')
    expect(user.session_token).not_to be_nil
  end
end

describe '#reset_session_token' do
  # before :each do
  #   old = harry.session_token
  #   harry.reset_session_token
  #   new_s = harry.session_token
  # end

  it 'assigns a new session_token' do
    old = harry.session_token
    harry.reset_session_token
    new_s = harry.session_token

    expect(new_s).not_to eq(old)
  end

  it 'returns the new session_token' do
    expect(harry.reset_session_token).to eq(harry.session_token)
  end
end

describe '#password=' do
  it "does not save password in db" do
    User.create(username: 'harry', password: 'abcdef')
    user = User.find_by(username: 'harry')
    expect(user.password).not_to eq('abcdef')
  end

  it 'encrypts password using BCrypt' do
    expect(BCrypt::Password).to receive(:create).with('abcdef')
    User.create(username: 'harry', password: 'abcdef')
  end
end


end
