class AddCommentPositionToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :comment_position, :integer
  end
end
