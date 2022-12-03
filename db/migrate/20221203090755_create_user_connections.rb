class CreateUserConnections < ActiveRecord::Migration[5.2]
  def change
    create_table :user_connections do |t|
      t.integer :click_in_user_id, null: false
      t.integer :followed_user_id, null: false

      t.timestamps :null => false
    end
  end
end
