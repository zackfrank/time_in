class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.string :status
      t.integer :student_id
      t.integer :user_id
      t.integer :attendance_record_id
      t.boolean :admin_booking

      t.timestamps
    end
  end
end
