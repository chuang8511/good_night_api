module Resource::V1

  class ClickInUsersApi < Grape::API

    resource :click_in_user do

      namespace do

        params do
          requires :user_id, type: Integer
          requires :follow_user_id, type: Integer
        end

        post '/follow' do

          user_id        = params[:user_id]
          follow_user_id = params[:follow_user_id]

          id = CommandService.follow_user(user_id, follow_user_id)

          response = { connection_id: id }
          present response
        end


      end

      namespace do

        params do
          requires :connection_id, type: Integer
        end

        post 'unfollow' do

          connection_id = params[:connection_id]

          CommandService.unfollow_user(connection_id)

        end

      end


    end

  end


end
