class CommandService

  class << self

    def save_click_time(user_id, click_type, click_time, response)

      click_type_integer = get_click_type(click_type)

      sleep_length = get_sleep_length(click_type_integer, click_time, response)

      Repository.save_click_time(user_id, click_type_integer, click_time, sleep_length)
    end

    def follow_user(user_id, follow_user_id)
      data = Repository.follow_user(user_id, follow_user_id)
      return data.id
    end

    def unfollow_user(connection_id)
      Repository.unfollow_user(connection_id)
    end


    private

    Repository = Persistences::Repository

    def get_click_type(click_type)
      return 1 if click_type == "wake_up"
      return 2 if click_type == "go_to_sleep"
    end

    def get_sleep_length(click_type_integer, click_time, response)
      if click_type_integer == 1
        last_sleep_time = response.detect {|hash| hash[:click_type] == "go_to_sleep"}[:recorded_time]

        (click_time - last_sleep_time).to_i
      else
        nil
      end

    end


  end


end
