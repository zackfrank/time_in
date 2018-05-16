class AddUserAndRequestToCarpools < ActiveRecord::Migration[5.1]
  def change
    add_column :carpools, :request, :string
    add_column :carpools, :user_id, :integer
  end
end
