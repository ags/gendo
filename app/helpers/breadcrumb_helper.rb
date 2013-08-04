module BreadcrumbHelper
  def add_app_index_breadcrumb
    add_crumb "Apps", apps_path
  end

  def add_app_breadcrumb(object)
    add_crumb object.app_name, app_path(object.app)
  end

  def add_source_breadcrumb(object)
    add_crumb object.source_name, app_source_path(object.app, object.source)
  end

  def add_request_breadcrumb(object)
    add_crumb object.request_name,
      app_request_path(object.app, object.request)
  end
end
