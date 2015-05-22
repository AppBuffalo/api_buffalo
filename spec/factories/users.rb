# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  email       :character varyin
#  fb_token    :character varyin
#  created_at  :timestamp withou not null
#  updated_at  :timestamp withou not null
#  device_id   :character varyin not null
#  device_type :character varyin not null
#

FactoryGirl.define do
  factory :user do
    device_type "android"
    device_id Random.rand(0..10000)
  end
end
