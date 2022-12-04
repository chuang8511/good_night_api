class SleepRecordDto < Struct.new(:record_date, :sleep_seconds)

  def sleep_length
    mins  = sleep_seconds / 60
    hours = mins / 60
    "#{hours}:#{mins % 60}:#{sleep_seconds % 60}"
  end

end
