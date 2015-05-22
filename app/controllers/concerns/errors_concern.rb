module ErrorsConcern
  extend ActiveSupport::Concern

  def user_not_found
    return_value({ error: "Can't find user." })
  end
end