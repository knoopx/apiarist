require 'active_support/concern'

module Apiarist
  module Controller
    module Serialization
      extend ActiveSupport::Concern
      include Apiarist::Serialization

      included do
        class_attribute :_serialization_scope
        self._serialization_scope = :default
      end

      def serialization_context
        self
      end

      module ClassMethods
        def serialization_scope(name, opts = {})
          before_filter(opts) { self._serialization_scope = name }
        end
      end
    end
  end
end