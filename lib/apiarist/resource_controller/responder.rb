require 'action_controller/metal/responder'
require 'active_support/core_ext/module/delegation'

module Apiarist
  module ResourceController
    class Responder < ActionController::Responder
      delegate :serialize, :resource_class, :_serialization_scope, to: :controller

      def display(resource, options = {})
        return super(resource, options) if resource.is_a?(String)

        if resource.respond_to?(:each)
          root = resource_class.name.underscore.pluralize
        else
          root = resource_class.name.underscore
        end

        super({root => serialize(resource, scope: _serialization_scope)}, options)
      end
    end
  end
end
