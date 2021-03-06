class PhotosController < ApplicationController

  api :POST, '/photos', "Create a new photo record and return its id."
  param :user_id, Integer, required: true, desc: "User's id"
  param :lat, Float, required: true, desc: "Photo's latitude"
  param :long, Float, required: true, desc: "Photo's longitude"
  param :s3_url, String, required: true, desc: "Photo's S3 URL"
  param :comment, String, required: true, desc: "Photo's comment"
  param :comment_position, Integer, required: false, desc: "Comment Y position"
  example "{id: 23}"
  def create
    json = if params.include?(:user_id) && params.include?(:lat) && params.include?(:long) && params.include?(:s3_url) &&
              params.include?(:comment) && !params[:user_id].nil? && !params[:lat].nil? && !params[:long].nil? &&
              !params[:s3_url].nil? && !params[:comment].nil?

             params[:comment_position] ||= nil

             if photo = Photo.create(user_id: params[:user_id], latitude: params[:lat],
                                     longitude: params[:long], s3_url: params[:s3_url], comment: params[:comment],
                                     comment_position: params[:comment_position])
               { id: photo.id }
             else
               { id: nil }
             end
           else
             { id: nil }
           end
    return_value json
  end

  api :GET, '/photos/:id', "Return photo's infos."
  param :id, Integer, required: true, desc: "Photo's id"
  example "{id: 5, user_id: 12, latitude: -5.2, longitude: 5.65, s3_url: 'http://s3.com/photo.png', comment: 'Zamel', comment_position: 5, score: 5}"
  def show
    json = if params.include?(:id) && !params[:id].nil?
             photo = Photo.find_by_id(params[:id])
             if photo.nil?
               { id: nil }
             else
               {
                   id: photo.id,
                   user_id: photo.user_id,
                   latitude: photo.latitude,
                   longitude: photo.longitude,
                   s3_url: photo.s3_url,
                   comment: photo.comment,
                   comment_position: photo.comment_position,
                   score: photo.get_score
               }
             end
           else
             { id: nil }
           end
    return_value json
  end

  api :GET, '/photos', "Return a list of 10 photos."
  param :latitude, Float, required: true, desc: "User's latitude"
  param :longitude, Float, required: true, desc: "User's longitude"
  param :user_id, Integer, required: true, desc: "User's id"
  param :size, Integer, required: false, desc: "Number of image to retrieve"
  example '[
    {
        "id": 1,
        "s3_url": "http:/ssdfsf",
        "score": 56,
        "comment": "zamel",
        "comment_position": 134
    },{...}
]'
  def index
    params[:size] ||= 1

    json = if params.include?(:user_id) && params.include?(:latitude) && params.include?(:longitude) &&
              !params[:user_id].nil? && !params[:latitude].nil? && !params[:longitude].nil?

             user = User.find_by_id params[:user_id]

             if user.nil?
               []
             else
               photos = Photo.where.not(user_id: params[:user_id])
                  .where.not(id: user.find_voted_items.map(&:id))
                  .near([params[:latitude], params[:longitude]])
                  .limit(params[:size])

               if photos.nil?
                 []
               else
                 temp = []
                 photos.each do |p|
                   temp.push({
                      id: p.id,
                      s3_url: p.s3_url,
                      score: p.get_score,
                      comment: p.comment,
                      comment_position: p.comment_position
                    })
                 end
                 temp
               end
             end
           else
             []
           end
    return_value json
  end
end
