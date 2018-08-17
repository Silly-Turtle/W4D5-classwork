# == Schema Information
#
# Table name: users
#
#  id            :bigint(8)        not null, primary key
#  name          :string           not null
#  password      :string           not null
#  session_token :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:password_digest) }
  it { should validate_presence_of(:session_token) }
  it { should validate_length_of(:password).is_at_least(6) }
  #it { should have_many (:name) }

  describe "uniqueness" do
    before :each do
      create (:user)
    end
    it { should validate_uniqueness_of (:name)}
  end

  describe "is_password?" do
    let(:user) {create :user}
    context "with a valid password" do
      it "should return true" do
        expect(user.is_password?("password")).to be true
      end
    end

    context "with an invalid password" do
      it "should return false" do
        expect(user.is_password?("startrek")).to be false
      end
    end
  end

  describe "find_by_credentials" do
    User.create(name: "asdf", password: "password")
    let! (:user) {User.last}
    it "should find the user" do
      expect(User.find_by_credentials("asdf", "password")).to be_a User
    end

    it "should be nil if credentials are invalid" do
      expect(User.find_by_credentials("asdf", "123456")).to be nil
    end

  end



end
