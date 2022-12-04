module Resource::V1

  class Root < Grape::API
    version 'v1'
    format :json
    content_type :json, 'application/json'


    mount Resource::V1::ClickInOperationApi
    mount Resource::V1::ClickInUsersApi
    mount Resource::V1::FriendRecordsApi
  end

end
