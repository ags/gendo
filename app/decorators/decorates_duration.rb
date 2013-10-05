module DecoratesDuration
  def duration(precision: 2)
    "#{object.duration.round(precision)} ms"
  end
end
