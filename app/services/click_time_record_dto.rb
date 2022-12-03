class ClickTimeRecordDto < Struct.new(:type_integer,
                                      :recorded_datetime)

  def click_type_string
    return "wake_up" if type_integer == 1
    return "go_to_sleep" if type_integer == 2
  end

end
