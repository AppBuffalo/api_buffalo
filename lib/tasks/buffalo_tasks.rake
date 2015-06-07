namespace :buffalo_tasks do
  desc "Remove photos every 23 hours"
  task delete_photos: :environment do
    photos = Photo.where("created_at > ?", 23.hours.ago)
    puts "#{Time.now} : #{photos.size} photos deleted"
    photos.delete_all
  end
end
