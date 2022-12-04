module Persistences

  class QueryService

    class << self

      def get_user_click_histories(user_id)
        ClickInRecord
          .where(click_in_user_id: user_id)
          .order(record_datetime: :desc)
          .as_json(only: [:click_type, :record_datetime])
      end


    end


  end


end
