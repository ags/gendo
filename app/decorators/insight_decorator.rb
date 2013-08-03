class InsightDecorator < Draper::Decorator
  delegate_all

  def partial_name
    "/#{object.class.name.underscore}"
  end
end
