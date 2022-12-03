class CreateClickInUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :click_in_users do |t|
      t.string :name

      t.timestamps :null => false
    end
  end
end
