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

    private

    Query = Persistences::QueryService



  end


end
