class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.date :date
      t.string :status
      t.integer :student_id
      t.integer :user_id
      t.integer :time_slot_id

      t.timestamps
    end
  end
end
