class AppDecorator < Draper::Decorator
  delegate_all

  def alphabetized_sources
    sources.order(:controller, :action).decorate
  end

  def collecting_data?
    sources.any?
  end
end
