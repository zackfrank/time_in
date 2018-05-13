class CreateCarpools < ActiveRecord::Migration[5.1]
  def change
    create_table :carpools do |t|
      t.string :name

      t.timestamps
    end
  end
end
