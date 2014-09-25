require 'memoizable'

module PostcodeAnywhere
  class ModelBase
    include Memoizable
    attr_reader :attrs
    alias_method :to_h, :attrs
    alias_method :to_hash, :to_h

    class << self
      def attr_reader(*attrs)
        attrs.each do |attr|
          define_attribute_method(attr)
          define_predicate_method(attr)
        end
      end

      def predicate_attr_reader(*attrs)
        attrs.each do |attr|
          define_predicate_method(attr)
          deprecate_attribute_method(attr)
        end
      end

      def object_attr_reader(klass, key1, key2 = nil)
        define_attribute_method(key1, klass, key2)
        define_predicate_method(key1)
      end

      def define_attribute_method(key1, klass = nil, key2 = nil)
        define_method(key1) do ||
          if @attrs[key1].nil? || @attrs[key1].respond_to?(:empty?) && @attrs[key1].empty?
            # NullObject.new
          else
            if klass.nil?
              @attrs[key1]
            else
              attrs = attrs_for_object(key1, key2)
              PostcodeAnywhere.const_get(klass).new(attrs)
            end
          end
        end
        memoize(key1)
      end

      def define_predicate_method(key1, key2 = key1)
        define_method(:"#{key1}?") do ||
          !@attrs[key2].nil? &&
          @attrs[key2] != false &&
          !(@attrs[key2].respond_to?(:empty?) &&
          @attrs[key2].empty?)
        end
        memoize(:"#{key1}?")
      end
    end

    def initialize(attrs = {})
      @attrs = attrs || {}
    end

    private

    def attrs_for_object(key1, key2 = nil)
      if key2.nil?
        @attrs[key1]
      else
        attrs = @attrs.dup
        attrs.delete(key1).merge(key2 => attrs)
      end
    end
  end
end
