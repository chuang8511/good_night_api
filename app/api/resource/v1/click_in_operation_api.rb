module Resource::V1

  class ClickInOperationApi < Grape::API

    resource :click_in do

      params do
        requires :user_id, type: Integer
        requires :click_type, type: String, desc: 'wake up or sleep'
      end

      post '/' do

        user_id    = params[:user_id]
        click_type = params[:click_type]
        click_time = Time.zone.now

        click_time_dtos = QueryService.get_user_click_histories(user_id)

        response = []

        response << { click_type: click_type, recorded_time: click_time }

        click_time_dtos.each do |dto|

          response << { click_type: dto.click_type_string, recorded_time: dto.recorded_datetime }

        end

        CommandService.save_click_time(user_id, click_type, click_time, response)

        present response

      end

      # todo: add specific time click-in API


      # todo: add destroy click-in data API


    end


  end

end
