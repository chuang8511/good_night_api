module Resource::V1

  class ClickInOperationApi < Grape::API

    resource :click_in do

      params do
        requires :user_id, type: Integer
        requires :click_type, type: String, values: ["wake_up", "go_to_sleep"]
        optional :click_time, type: String, regexp: ::RegularExpressionDefinition::REG_DATETIME_STYLE_1
      end

      helpers do

        def append_errors!(click_type, parsed_click_time, click_time_dtos)
          @error_messages = ValidationService.error_messages(click_type, parsed_click_time, click_time_dtos)
        end

      end

      post '/' do

        user_id    = params[:user_id]
        click_type = params[:click_type]
        click_time = params[:click_time]
        parsed_click_time = click_time.present? ? Time.zone.parse(click_time) : Time.zone.now

        click_time_dtos = QueryService.get_user_click_histories(user_id)

        # only can click in the latest records.
        append_errors!(click_type, parsed_click_time, click_time_dtos)
        error! @error_messages, 400 if @error_messages.present?

        response = []

        response << { click_type: click_type, recorded_time: parsed_click_time }

        click_time_dtos.each do |dto|

          response << { click_type: dto.click_type_string, recorded_time: dto.recorded_datetime }

        end

        CommandService.save_click_time(user_id, click_type, parsed_click_time, response)

        present response

      end

    end


  end

end
