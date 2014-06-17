require 'action_controller/metal/responder'
require 'active_support/core_ext/module/delegation'

module Apiarist
  module ResourceController
    class Responder < ActionController::Responder
      delegate :serialize, :_serialization_scope, to: :controller

      def display(resource, options = {})
        if resource.respond_to?(:each)
          root = controller.send(:resource_class).name.underscore.pluralize
        else
          root = controller.send(:resource_class).name.underscore
        end

        super({root => serialize(resource, scope: _serialization_scope)}, options)
      end
    end
  end
end
