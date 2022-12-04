class CreateUserSleepLengthRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :user_sleep_length_records do |t|
      t.integer :click_in_user_id, null: false
      t.date :record_date, null: false
      t.integer :sleep_seconds, null: false

      t.timestamps :null => false
    end
    add_index :user_sleep_length_records, :click_in_user_id
  end
end
