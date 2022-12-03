module Resource

  class Endpoint < Grape::API

    prefix 'good_night'

    mount Resource::V1::Root
  end

end

