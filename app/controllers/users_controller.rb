class UsersController < ApplicationController

  api :GET, '/users', "Authentication method. Return User's id if found and nil if not."
  param :device_type, String, required: true, desc: "User's device type (android or ios)"
  param :device_id, String, required: true, desc: "Users's unique device id"
  example "{id: 5}"
  def show
    user = if params.include?(:device_type) && params.include?(:device_id) && !params[:device_type].nil? && !params[:device_type].nil?
             User.where(device_type: params[:device_type]).where(device_id: params[:device_id])
           else
             []
           end
    json = user.any? ? { id: user.first.id } : { id: nil }
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

end