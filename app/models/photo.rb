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

class Photo < ActiveRecord::Base
  belongs_to :user

  reverse_geocoded_by :latitude, :longitude
  after_validation :reverse_geocode

  def reverse_geocode
  end
end
