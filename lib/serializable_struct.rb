module SerializableStruct
  def read_attribute_for_serialization(name)
    __send__(name)
  end
end
