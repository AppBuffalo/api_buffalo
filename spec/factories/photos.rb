# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  latitude   :double precision
#  longitude  :double precision
#  s3_url     :character varyin
#  created_at :timestamp withou not null
#  updated_at :timestamp withou not null
#

FactoryGirl.define do
  factory :photo do
    user_id 1
    latitude 1.5
    longitude 1.5
    s3_url "s3_test"
  end
end
