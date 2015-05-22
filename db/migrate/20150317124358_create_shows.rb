class CreateShows < ActiveRecord::Migration
  def change
    create_table :shows do |t|
      t.integer :user_id, null: false
      t.string :imdbid, null: false

      t.timestamps null: false
    end
  end
end
