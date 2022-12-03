class CreateClickInRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :click_in_records do |t|
      t.integer :click_in_user_id, null: false
      t.integer :type, null: false
      t.datetime :record_datetime, null: false

      t.timestamps :null => false
    end
  end
end
