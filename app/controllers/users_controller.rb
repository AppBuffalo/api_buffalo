class UsersController < ApplicationController

  api :GET, '/users', "Authentication method. Return User's id if found (nil if not), user's total score and user's total number of photos send."
  param :device_type, String, required: true, desc: "User's device type (android or ios)"
  param :device_id, String, required: true, desc: "Users's unique device id"
  example "{id: 5, score: 56, photo_size: 3}"
  def show
    user = if params.include?(:device_type) && params.include?(:device_id) && !params[:device_type].nil? && !params[:device_type].nil?
             User.where(device_type: params[:device_type]).where(device_id: params[:device_id])
           else
             []
           end
    json = user.any? ? { id: user.first.id, score: user.first.get_score, photo_size: user.first.photo_size } : { id: nil }
    return_value json
  end

  api :POST, '/users', "Create a new user and return his id. Return user's id if already registered."
  param :device_type, String, required: true, desc: "Type of device (android or ios)"
  param :device_id, String, required: true, desc: "Device's unique ID"
  example "{id: 4}"
  def create
    user = User.where(device_id: params[:device_id]).where(device_type: params[:device_type])
    json = if user.any?
             { id: user.first.id }
           else
             if params.include?(:device_id) && params.include?(:device_type) &&
                 !params[:device_id].nil? && !params[:device_type].nil?
               user = User.create(device_id: params[:device_id], device_type: params[:device_type])
               { id: user.id }
             else
               { id: nil }
             end
           end
      return_value json
  end

  api :POST, '/users/:user_id/like/:photo_id', "Action when an user likes a photo"
  param :user_id, Integer, required: true, desc: "User's id"
  param :photo_id, Integer, required: true, desc: "Photo's id"
  example "{success: true}"
  def like
    if params.include?(:user_id) && params.include?(:photo_id) && !params[:user_id].nil? && !params[:photo_id].nil?
      user = User.find_by_id(params[:user_id])
      photo = Photo.find_by_id(params[:photo_id])

      if user.nil? || photo.nil?
        json = { success: false }
      else
        photo.liked_by user
        photo.user.score += 1
        photo.user.save
        json = { success: true }
      end
    else
      json = { success: false }
    end

    return_value json
  end

  api :POST, '/users/:user_id/dislike/:photo_id', "Action when an user dislikes a photo"
  param :user_id, Integer, required: true, desc: "User's id"
  param :photo_id, Integer, required: true, desc: "Photo's id"
  example "{success: true}"
  def dislike
    if params.include?(:user_id) && params.include?(:photo_id) && !params[:user_id].nil? && !params[:photo_id].nil?
      user = User.find_by_id(params[:user_id])
      photo = Photo.find_by_id(params[:photo_id])

      if user.nil? && photo.nil?
        json = { success: false }
      else
        photo.downvote_from user

        photo.user.score -= 1
        photo.user.save

        photo.destroy if photo.score < -20

        json = { success: true }
      end
    else
      json = { success: false }
    end

    return_value json
  end
end