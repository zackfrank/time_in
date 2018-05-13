class AddWaypointsToCarpool < ActiveRecord::Migration[5.1]
  def change
    add_column :carpools, :start, :string
    add_column :carpools, :waypoints, :string
  end
end
