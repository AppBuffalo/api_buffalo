class ChangeTypeDeviceId < ActiveRecord::Migration
  def change
    remove_column :users, :device_id, :integer
    remove_column :users, :device_type, :string

    add_column :users, :device_id, :string, null: false
    add_column :users, :device_type, :string, null: false
  end
end
