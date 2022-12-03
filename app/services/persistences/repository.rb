module Persistences
  class Repository

    class << self

      def save_click_time(user_id, click_type_integer, click_time, sleep_length)
        ActiveRecord::Base.transaction do

          ClickInRecord.create!(click_in_user_id: user_id,
                                click_type:       click_type_integer,
                                record_datetime:  click_time)

          UserSleepLengthRecord.create!(click_in_user_id: user_id,
                                        record_date:      click_time.to_date,
                                        sleep_seconds:    sleep_length) if sleep_length.present?

        end
      end

    end


  end
end
