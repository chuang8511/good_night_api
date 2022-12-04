module Resource::V1

  class FriendRecordsApi < Grape::API

    resource :click_in_user_friend do

      namespace do

        params do
          requires :user_id, type: Integer
        end

        get 'friends' do

          present QueryService.get_friends(params[:user_id])

        end

      end



      namespace do

        params do
          requires :friend_user_id, type: Integer
        end

        get 'records' do

          sleep_record_dtos = QueryService.get_friend_sleep_records(params[:friend_user_id])

          response = sleep_record_dtos.map { |dto| { record_date: dto.record_date, sleep_length: dto.sleep_length } }

          present response

        end

      end




    end

  end
end
