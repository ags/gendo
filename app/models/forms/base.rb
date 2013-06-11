require 'active_attr'

module Forms
  class Base
    include ActiveAttr::Attributes
    include ActiveAttr::BasicModel
    include ActiveAttr::MassAssignment
    include ActiveModel::ForbiddenAttributesProtection
  end
end
