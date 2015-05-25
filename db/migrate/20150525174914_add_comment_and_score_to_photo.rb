class AddCommentAndScoreToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :comment, :string
    add_column :photos, :score, :integer, default: 0
  end
end
