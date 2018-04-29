class CreateAttendanceRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :attendance_records do |t|
      t.date :date
      t.string :time
      t.integer :capacity

      t.timestamps
    end
  end
end
