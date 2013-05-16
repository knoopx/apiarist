require 'delegate'
require 'active_support/core_ext/array/extract_options'

module Apiarist
  class Serializer < SimpleDelegator
    include Apiarist::Serialization

    attr_reader :context

    def initialize(resource, context = self, opts = {})
      @resource = resource, @context = context
      @options = opts
      super(resource)
    end

    alias_method :resource, :__getobj__

    def as_json(_ = {})
      json = {}
      _keys.each_with_object(json) do |(name, opts), hash|
        serialization_opts = opts.dup
        key = serialization_opts.delete(:as) || name

        if serialization_scope_include?(serialization_opts.delete(:if))
          case serialization_opts.delete(:type)
            when :association
              value = serialize(send(name), serialization_opts)
            else
              value = send(name)
          end

          hash[key] = value
        end
      end

      json
    end

    def serialization_context
      context.serialization_context
    end

    class << self
      def attribute(name, opts = {})
        self._keys = _keys.dup
        _keys[name] = opts
      end

      def attributes(*names)
        opts = names.extract_options!
        names.each { |name| attribute(name, opts) }
      end

      def association(name, opts = {})
        attribute(name, opts.merge(type: :association))
      end

      def associations(*associations)
        opts = associations.extract_options!
        associations.each { |name| association(name, opts) }
      end

      def scope(name, &block)
        with_options(if: name) do |scope|
          scope.instance_eval(&block)
        end
      end
    end

    private

    class_attribute :_keys
    self._keys = {}

    def serialization_scope_include?(scope)
      [@options[:scope], nil].flatten.include?(scope)
    end
  end
end