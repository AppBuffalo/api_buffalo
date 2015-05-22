class AddDeviceIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :device_id, :integer
    add_column :users, :device_type, :string
  end
end
