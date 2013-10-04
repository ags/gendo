require 'active_attr'

module Form
  module Model
    def self.included(klass)
      [
        ActiveAttr::Attributes,
        ActiveAttr::BasicModel,
        ActiveAttr::MassAssignment,
        ActiveModel::ForbiddenAttributesProtection,
      ].each { |mod| klass.include(mod) }
    end
  end
end
