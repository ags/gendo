class InvalidAuthentication < Struct.new(:message)
  include SerializableStruct

  def valid?
    false
  end
end
