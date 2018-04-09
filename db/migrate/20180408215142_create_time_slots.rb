class CreateTimeSlots < ActiveRecord::Migration[5.1]
  def change
    create_table :time_slots do |t|
      t.string :day
      t.string :time
      t.integer :capacity
      t.boolean :high_school_only

      t.timestamps
    end
  end
end
