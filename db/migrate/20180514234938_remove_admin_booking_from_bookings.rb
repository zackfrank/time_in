class RemoveAdminBookingFromBookings < ActiveRecord::Migration[5.1]
  def change
    remove_column :bookings, :admin_booking, :boolean
  end
end
