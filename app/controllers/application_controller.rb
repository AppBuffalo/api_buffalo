class ApplicationController < ActionController::API
  include ErrorsConcern

  def return_value value
    render json: value
  end
end
