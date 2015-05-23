require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET /users" do
    it "should return nil if no parameters" do
      get 'show'
      expect_json({ id: nil })
    end

    it "should return nil if parameters are empty" do
      get 'show', { device_type: nil, device_id: nil }
      expect_json({ id: nil })
    end

    it "should return an id if user exists" do
      user = FactoryGirl.create(:user)
      get 'show', { email: user.email, password: user.password }
      expect_json({ id: user.id })
    end
  end

  describe "POST /users" do
    it "should return nil if no parameters" do
      get 'create'
      expect_json({ id: nil })
    end

    it "should return nil if parameters are empty" do
      get 'create', { device_type: nil, device_id: nil }
      expect_json({ id: nil })
    end

    it "should return an id if user exists" do
      user = FactoryGirl.create(:user)
      get 'create', { device_type: user.device_type, device_id: user.device_id }
      expect_json({ id: user.id })
    end

    it "should create an user and return an id if user does not exist" do
      get 'create', { device_type: 'android', device_id: '345345345'}
      expect(User.last.device_id).to eq('345345345')
      expect_json_types({ id: :integer })
    end
  end
end