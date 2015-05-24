class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.integer :user_id
      t.float :latitude
      t.float :longitude
      t.string :s3_url

      t.timestamps null: false
    end
  end
end
