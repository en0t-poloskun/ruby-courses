# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :validations

    def validate(name, method, extra = nil)
      self.validations ||= []
      self.validations << if extra.nil?
                            "send(:#{method}, :@#{name})"
                          else
                            "send(:#{method}, :@#{name}, #{extra})"
                          end
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue StandardError
      false
    end

    private

    def validate!
      self.class.validations.each { |validation| eval(validation) }
    end

    def presence(name)
      raise "#{name} can't be nil" if instance_variable_get(name).nil?
      return unless instance_variable_get(name).methods.include?(:empty?)

      raise "#{name} can't be empty" if instance_variable_get(name).empty?
    end

    def format(name, regex)
      raise "Invalid format for #{name}" if instance_variable_get(name) !~ regex
    end

    # изменила название, чтобы не совпадало с геттером атрибута type
    def required_type(name, required_class)
      raise "#{name} must be of type #{required_class}" if instance_variable_get(name).class != required_class
    end
  end
end
