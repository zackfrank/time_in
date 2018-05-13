class AddCarpoolIdToBooking < ActiveRecord::Migration[5.1]
  def change
    add_column :bookings, :carpool_id, :integer
  end
end
