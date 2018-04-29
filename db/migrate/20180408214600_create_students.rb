class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.boolean :high_school
      t.integer :account_id
      t.date :birthday
      t.boolean :active?

      t.timestamps
    end
  end
end
