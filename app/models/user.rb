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
#  password    :character varyin
#

class User < ActiveRecord::Base
end
