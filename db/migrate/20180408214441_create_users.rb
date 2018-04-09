class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.integer :account_id
      t.string :relationship
      t.string :phone_number
      t.boolean :active?

      t.timestamps
    end
  end
end
