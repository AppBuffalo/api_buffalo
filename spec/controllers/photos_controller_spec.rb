require 'rails_helper'

RSpec.describe PhotosController, type: :controller do
  describe "POST /photos" do
    it "should return nil if no parameters" do
      get 'create'
      expect_json({ id: nil })
    end

    it "should return nil if parameters are empty" do
      get 'create', { user_id: nil, s3_url: nil, lat: nil, long: nil }
      expect_json({ id: nil })
    end

    it "should create a photo and return an id if all params are good" do
      get 'create', { user_id: 1, s3_url: "url", lat: -5, long: 6 }
      expect(Photo.last.user_id).to eq(1)
      expect_json_types({ id: :integer })
    end
  end

  describe "GET /photos/:id" do
    it "should return an id if user exists" do
      photo = FactoryGirl.create(:photo)
      get 'show', { id: photo.id }
      expect_json({ id: photo.id, user_id: photo.user_id, latitude: photo.latitude,
                    longitude: photo.longitude, s3_url: photo.s3_url })
    end
  end
end