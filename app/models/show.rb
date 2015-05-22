# == Schema Information
#
# Table name: shows
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  imdbid     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Show < ActiveRecord::Base
end
