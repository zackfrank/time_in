class AddAttendanceRecordIdToCarpool < ActiveRecord::Migration[5.1]
  def change
    add_column :carpools, :attendance_record_id, :integer
  end
end
