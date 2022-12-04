module Persistences

  class QueryService

    class << self

      def get_user_click_histories(user_id)
        ClickInRecord
          .where(click_in_user_id: user_id)
          .order(record_datetime: :desc)
          .as_json(only: [:click_type, :record_datetime])
      end

      def get_friends(user_id)
        friend_ids = UserConnection
                       .joins("LEFT JOIN user_disconnections ON user_disconnections.user_connection_id = user_connections.id")
                       .where(user_connections: { click_in_user_id: user_id })
                       .where(user_disconnections: { id: nil }).pluck(:followed_user_id)

        ClickInUser
          .where(id: friend_ids)
          .as_json(only: [:id, :name])
      end

      def get_friend_sleep_records(friend_user_id)
        UserSleepLengthRecord
          .where(click_in_user_id: friend_user_id)
          .order(sleep_seconds: :desc)
          .as_json(only: [:record_date, :sleep_seconds])
      end

    end


  end


end
