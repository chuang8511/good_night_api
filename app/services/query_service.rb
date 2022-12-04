class QueryService

  class << self

    def get_user_click_histories(user_id)
      click_records_array = Query.get_user_click_histories(user_id)

      user_click_histories = []

      click_records_array.each do |hash_data|

        user_click_histories << ClickTimeRecordDto.new(hash_data["click_type"], hash_data["record_datetime"])

      end

      user_click_histories
    end

    def get_friends(user_id)
      friends_array = Query.get_friends(user_id)

      friends_dtos = []

      friends_array.each do |friend|

        friends_dtos << FriendInfoDto.new(friend["id"], friend["name"])

      end

      friends_dtos

    end

    def get_friend_sleep_records(friend_user_id)
      sleep_records_array = Query.get_friend_sleep_records(friend_user_id)

      sleep_record_dto = []

      sleep_records_array.each do |sleep_record|

        sleep_record_dto << SleepRecordDto.new(sleep_record["record_date"], sleep_record["sleep_seconds"])

      end

      sleep_record_dto

    end

    private

    Query = Persistences::QueryService



  end


end
