require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/string/inflections'

module Apiarist
  module Serialization
    def serialize(obj, opts = {})
      if obj.respond_to?(:map)
        obj.map { |resource| serialize_object(resource, opts) }
      else
        serialize_object(obj, opts)
      end
    end

    private

    def serialize_object(obj, opts = {})
      opts.assert_valid_keys(:scope, :context, :serializer)

      if obj
        serializer = opts.fetch(:serializer) { serializer_class(obj.class) }
        serializer.new(obj, serialization_context, opts)
      end
    end

    def serializer_class(resource_class)
      "#{self.class.name.deconstantize}::#{resource_class}Serializer".constantize
    end
  end
end
