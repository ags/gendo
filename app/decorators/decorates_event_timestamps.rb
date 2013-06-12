module DecoratesEventTimestamps
  def started_at
    object.started_at.strftime('%Y-%m-%d %H:%M:%S.%6N')
  end

  def ended_at
    object.ended_at.strftime('%Y-%m-%d %H:%M:%S.%6N')
  end
end
