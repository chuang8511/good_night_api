class CreateUserDisconnections < ActiveRecord::Migration[5.2]
  def change
    create_table :user_disconnections do |t|
      t.integer :user_connection_id, null: false

      t.timestamps :null => false
    end
  end
end
