module Resource::V1

  class Root < Grape::API
    version 'v1'
    format :json
    content_type :json, 'application/json'


    mount Resource::V1::ClickInOperationApi
  end

end
