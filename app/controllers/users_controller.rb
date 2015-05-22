class UsersController < ApplicationController
  before_action :set_user, only: [:shows, :add_show]

  api :GET, '/users', "Authentication method. Return User's id if found and nil if not."
  param :device_type, String, required: true, desc: "Type of device (android or ios)"
  param :device_id, :number, required: true, desc: "Device's unique ID"
  example "{id: 5}"
  def show
    user = if params.include?(:device_id) && params.include?(:device_type) && !params[:device_id].nil? && !params[:device_type].nil?
             User.where(device_id: params[:device_id]).where(device_type: params[:device_type])
           else
             []
           end
    json = user.any? ? { id: user.first.id } : { id: nil }
    return_value json
  end

  api :POST, '/users', "Create a new user and return his id. Return user's id if already registered."
  param :device_type, String, required: true, desc: "Type of device (android or ios)"
  param :device_id, :number, required: true, desc: "Device's unique ID"
  example "{id: 4}"
  def create
    user = User.where(device_id: params[:device_id]).where(device_type: params[:device_type])
    json = if user.any?
             { id: user.first.id }
           else
             if params.include?(:device_id) && params.include?(:device_type) && !params[:device_id].nil? && !params[:device_type].nil?
               user = User.create(device_id: params[:device_id], device_type: params[:device_type])
               { id: user.id }
             else
               { id: nil }
             end
           end
      return_value json
  end

  api :GET, '/users/:user_id/shows', "Return a list of shows tracked by a user."
  param :user_id, :number, required: true, desc: "User's ID"
  example '
  {
    "user_id": 2,
    "shows": []
  }'
  def shows
    shows = []
    @user.shows.each do |s|
      show = get_shows_infos_by_imdbid_omdb s.imdbid
      puts show
      shows.push( json_generate_show_ombd(show) )
    end
    return_value({ user_id: @user.id, shows: shows })
  end

  api :POST, '/users/:user_id/shows', "Add a show that a user want to track."
  param :imdb_id, String, required: true, desc: "IMDB ID"
  def add_show
    if params[:imdb_id].nil?
      imdb_id_null
    elsif get_title_omdb(params[:imdb_id]).nil?
      show_not_found
    else
      @user.shows.create(imdbid: params[:imdb_id])
      show_added
    end
  end

  private
  def set_user
    @user = if params.include?(:user_id) && !params[:user_id].nil?
              begin
                User.find(params[:user_id])
              rescue ActiveRecord::RecordNotFound
                nil
              end
            else
              nil
            end
    user_not_found if @user.nil?
  end
end