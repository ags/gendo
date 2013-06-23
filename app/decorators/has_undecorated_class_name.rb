module HasUndecoratedClassName
  def underscored_class_name
    object.class.name.underscore
  end
end
