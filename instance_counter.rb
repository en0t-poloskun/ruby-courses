# frozen_string_literal: true

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :instance_number

    def instances
      instance_number
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.instance_number ||= 0
      self.class.instance_number += 1
    end
  end
end
