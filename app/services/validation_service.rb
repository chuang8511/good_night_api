class ValidationService

  class << self

    def error_messages(click_type, parsed_click_time, click_time_dtos)
      response = ""
      if click_time_dtos.blank?
        response << "first click_type should be go_to_sleep" unless click_type == "go_to_sleep"
      elsif click_is_not_latest?(parsed_click_time, click_time_dtos)
        response << "click in should be the latest"
      else
        response << "click_type should different from last time" if click_time_dtos[0].click_type_string == click_type
      end
      response
    end

    private

    def click_is_not_latest?(parsed_click_time, click_time_dtos)
      click_time_dtos.any? { |dto| dto.recorded_datetime > parsed_click_time }
    end

  end

end
