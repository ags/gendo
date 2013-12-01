class InvalidAuthentication < Struct.new(:message)
  def valid?
    false
  end
end
