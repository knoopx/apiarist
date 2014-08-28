require 'action_controller/metal/responder'
require 'active_support/core_ext/module/delegation'

module Apiarist
  module ResourceController
    class Responder < ActionController::Responder
      delegate :serialize, :_serialization_scope, to: :controller

      def display(resource, options = {})
        super({root => serialize(resource, scope: _serialization_scope)}, options)
      end

      def root
        if resource.respond_to?(:each)
          controller.send(:resource_collection_name)
        else
          controller.send(:resource_instance_name)
        end
      end
    end
  end
end
