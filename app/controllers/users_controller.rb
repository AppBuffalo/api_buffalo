class UsersController < ApplicationController
  before_action :set_user, only: []

  api :GET, '/users', "Authentication method. Return User's id if found and nil if not."
  param :email, String, required: true, desc: "User's email"
  param :password, String, required: true, desc: "Users's password (sha3)"
  example "{id: 5}"
  def show
    user = if params.include?(:email) && params.include?(:password) && !params[:email].nil? && !params[:password].nil?
             User.where(email: params[:email]).where(password: params[:password])
           else
             []
           end
    json = user.any? ? { id: user.first.id } : { id: nil }
    return_value json
  end

  api :POST, '/users', "Create a new user and return his id. Return user's id if already registered."
  param :email, String , required: true, desc: "User's email"
  param :password, String, required: true, desc: "User's password"
  param :device_type, String, required: true, desc: "Type of device (android or ios)"
  param :device_id, String, required: true, desc: "Device's unique ID"
  example "{id: 4}"
  def create
    user = User.where(email: params[:email]).where(password: params[:password])
    json = if user.any?
             { id: user.first.id }
           else
             if params.include?(:device_id) && params.include?(:device_type) && params.include?(:email) && params.include?(:password)
                 !params[:device_id].nil? && !params[:device_type].nil? && !params[:email].nil? && !params[:password].nil?
               user = User.create(device_id: params[:device_id], device_type: params[:device_type],
                                  email: params[:email], password: params[:password])
               { id: user.id }
             else
               { id: nil }
             end
           end
      return_value json
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