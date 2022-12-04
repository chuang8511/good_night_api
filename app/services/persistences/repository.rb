# test github protections
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

      def follow_user(user_id, follow_user_id)
        UserConnection.create!(click_in_user_id: user_id,
                               followed_user_id: follow_user_id)
      end

      def unfollow_user(connection_id)
        UserDisconnection.create!(user_connection_id: connection_id)
        true
      end

    end

  end
end
