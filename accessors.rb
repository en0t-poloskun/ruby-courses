# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        var_name = "@#{name}".to_sym
        history = "@#{name}_history".to_sym

        define_method(name) { instance_variable_get(var_name) }

        define_method("#{name}_history") do
          instance_variable_set(history, []) if instance_variable_get(history).nil?
          instance_variable_get(history)
        end

        define_method("#{name}=".to_sym) do |value|
          instance_variable_set(history, []) if instance_variable_get(history).nil?
          instance_variable_set(var_name, value)
          instance_variable_set(history, instance_variable_get(history) << instance_variable_get(var_name))
        end
      end
    end

    def strong_attr_accessor(name, type)
      var_name = "@#{name}".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=".to_sym) do |value|
        raise "Attribute must be of type #{type}" if value.class != type

        instance_variable_set(var_name, value)
      end
    end
  end
end
